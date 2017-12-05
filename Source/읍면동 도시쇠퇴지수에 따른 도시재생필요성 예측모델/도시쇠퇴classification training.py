import tensorflow as tf
import numpy as np
import csv

# 경기도를 제외한 나머지 지역의 도시쇠퇴 데이터 읽기
training_data = np.genfromtxt('C:/Users/seil/Desktop/통계 및 R/R자료/Rstuio파일저장소/도시쇠퇴나머지정제.csv',
                dtype=np.float32, delimiter=',')

training_data = training_data[1:,1:]

# 경기도의 데이터 읽기
test_data = np.genfromtxt('C:/Users/seil/Desktop/통계 및 R/R자료/Rstuio파일저장소/도시쇠퇴경기도정제.csv',
                          dtype=np.float32, delimiter=',')

test_data = test_data[1:,0:]

# 경기도 지역을 출력하기 위한 데이터 읽기
with open('C:/Users/seil/Desktop/통계 및 R/R자료/Rstuio파일저장소/경기도지역이름.csv','r') as f:
    reader = csv.reader(f)
    dl = list(reader)


# 읽어드린 training 데이터의 정렬을 섞기
np.random.shuffle(training_data)

# 독립변수부분과 종속변수부분 나누기
x_data = training_data[0:, 2:-2]
y_data = training_data[0:, [-1]]

x_test = test_data[0:, 3:-2]
y_test = test_data[0:, [-1]]

X = tf.placeholder(tf.float32, shape=[None,5])
Y = tf.placeholder(tf.int32, shape=[None,1]) # 0 or 1

# y 데이터를 one-hot 데이터로 쓰기위한 변환( y변수의 값은 0과 1 두가지이다.)
Y_one_hot = tf.one_hot(Y, 2)
Y_one_hot = tf.reshape(Y_one_hot, [-1, 2])

# Layer1
W1 = tf.Variable(tf.random_normal([5,10]), name='weight')
b1 = tf.Variable(tf.random_normal([10]), name='bias')
layer1 = tf.nn.softmax(tf.matmul(X,W1) + b1)

# Layer2
W2 = tf.Variable(tf.random_normal([10,2]), name='weight')
b2 = tf.Variable(tf.random_normal([2]), name='bias')

logits = tf.matmul(layer1,W2) + b2
hypothesis = tf.nn.softmax(logits)


# Cross entropy cost/loss
cost_i = tf.nn.softmax_cross_entropy_with_logits(logits=logits, labels=Y_one_hot)

cost = tf.reduce_mean(cost_i)
optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.003).minimize(cost)

# training한 후 test set을 이용하여 예측하고 정확도를 계산
prediction = tf.argmax(hypothesis, 1)
correct_prediction = tf.equal(prediction, tf.argmax(Y_one_hot, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

sess = tf.Session()
sess.run(tf.global_variables_initializer())

# Launch graph
for step in range(1000000):
    sess.run(optimizer, feed_dict={X:x_data, Y:y_data})

    if step % 100 == 0:
        loss = sess.run(cost,
                        feed_dict={X:x_data, Y:y_data}) # dataset의 뒤의 90%를 training dataset으로 사용
        print("Step: {:5}\tLoss: {:.3f}".format(step, loss))

w1_value, w2_value, b1_value, b2_value = sess.run([W1,W2,b1,b2])
print("\tWeight1: {}\tBias1: {} \tWeight2: {}\tBias2: {}".format(w1_value, b1_value, w2_value, b2_value))


# 예측결과의 데이터를 자세하게 확인
pred = sess.run(prediction, feed_dict={X:x_test, Y:y_test})

i= 0
for p, y, x in zip(pred, y_data.flatten(), dl):
    i = i + 1
    print("[{}]  [{}] Prediction: {} True Y: {}".format(x ,p == int(y), p, int(y)))


# training 후의 예측정확도를 확인
print('\nAccuracy: ', sess.run(accuracy, feed_dict={X:x_test,Y:y_test}))
print('\n')

'''
# training 후의 예측정확도를 확인
print('Accuracy: ', sess.run(accuracy, feed_dict={X:x_data[0:begin-1],Y:y_data[0:begin-1]}))


# 예측결과의 데이터를 자세하게 확인
pred = sess.run(prediction, feed_dict={X:x_data[0:begin-1], Y:y_data[0:begin-1]})

i= 0
for p, y, x in zip(pred, y_data.flatten(), test_data[0:,0:3]):
    i = i + 1
    print("[{}]  [{}] Prediction: {} True Y: {} num: {}".format(x ,p == int(y), p, int(y), i))

    
'''

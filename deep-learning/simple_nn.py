from numpy import exp, array, random, dot

class NeuralNetwork():
    def __init__(self):

        random.seed(1)
        self.synaptic_weights = 2* random.random((3,1)) -1

    def __sigmoid(self,x):
        return 1/(1+ exp(-x))

    def __sigmoid_derivative(self,x):
        return x * (1-x)

    def train(self, training_in, training_out, iteration):
        for  itr in xrange(iteration):
            out =  self.predict(training_in)

            error = training_out - out

            adjustment = dot(training_in.T, error * self.__sigmoid_derivative(out))
            self.synaptic_weights += adjustment

    def predict(self, input):
         return self.__sigmoid(dot(input, self.synaptic_weights))

if __name__ == '__main__':
     # initialize a simple neural network
     neural_network = NeuralNetwork()

     print 'Random starting weights'
     print neural_network.synaptic_weights

     training_in = array([[0,0,1],[1,1,1],[1,0,1],[0,1,1,]])
     training_out = array([[0,1,1,0]]).T

     neural_network.train(training_in, training_out, 10000)

     print "new synaptic weights after training"

     print neural_network.synaptic_weights

     print "predicting for new input"
     print neural_network.predict(array([1,0,0]))

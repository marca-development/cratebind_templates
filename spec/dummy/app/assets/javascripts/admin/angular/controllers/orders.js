adminAppControllers.controller('OrdersIndexCtrl', ['$scope', 'Order', 'railsMessages',
    function($scope, Order, railsMessages) {
        $scope.q = {
            s: {}
        }

        $scope.sortToggle = function(attribute) {
            var descString = attribute + ' desc',
                ascString = attribute + ' asc'
            if ($scope.q.s == ascString) {
                $scope.q.s = descString
            } else {
                $scope.q.s = ascString
            }
            $scope.query();
        }

        $scope.query = function() {
            Order.search({}, {
                q: $scope.q,
                page: $scope.currentPage
            }, function(res, headers) {
                $scope.orders = res;
                $scope.totalItems = headers().totalitems;
                $scope.currentPage = headers().currentpage;
            });
        }

        $scope.destroyOrder = function(order) {
            Order.delete({
                id: order.id
            }, function() {
                var index = $scope.orders.indexOf(order);
                $scope.orders.splice(index, 1);
            }, function(err) {
                railsMessages.process(err);
            });
        }

        $scope.currentPage = 1;
        $scope.query();

    }
]);

adminAppControllers.controller('OrdersNewCtrl', ['$scope', 'Order', 'railsMessages', '$location',
    function($scope, Order, railsMessages, $location) {
        $scope.order = new Order();

        $scope.saveOrder = function(order) {
            Order.save(order, function(res) {
                railsMessages.add('Order was created successfully', 'alert alert-success');
                $location.path('//orders/' + res.id);
            }, function(err) {
                railsMessages.process(err);
            });
        }

    }
]);

adminAppControllers.controller('OrdersEditCtrl', ['$scope', 'railsMessages', '$location', 'Order', '$routeParams',
    function($scope, railsMessages, $location, Order, $routeParams) {

        $scope.order = Order.get({
            id: $routeParams.id
        });

        $scope.saveOrder = function(order) {
            order.$update({
                id: order.id
            }, function(res) {
                railsMessages.add('Order was updated successfully', 'alert alert-success');
                $location.path('//orders/' + res.id);
            }, function(err) {
                railsMessages.process(err);
            });
        }

    }
]);

adminAppControllers.controller('OrdersShowCtrl', ['$scope', 'Order', '$routeParams',
    function($scope, Order, $routeParams) {

        $scope.order = Order.get({
            id: $routeParams.id
        });

    }
]);

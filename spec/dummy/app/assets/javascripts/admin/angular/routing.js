adminApp.config(['$routeProvider', '$locationProvider',
    function($routeProvider, $locationProvider) {
        $routeProvider.
// orders
        when('/admin/orders',{
            templateUrl: '/angular/admin/orders/index.html',
            controller: 'OrdersIndexCtrl'
        }).

        when('/admin/orders/new',{
            templateUrl: '/angular/admin/orders/new.html',
            controller: 'OrdersNewCtrl'
        }).

        when('/admin/orders/:id/edit',{
            templateUrl: '/angular/admin/orders/edit.html',
            controller: 'OrdersEditCtrl'
        }).

        when('/admin/orders/:id',{
            templateUrl: '/angular/admin/orders/show.html',
            controller: 'OrdersShowCtrl'
        }).
        otherwise({
            redirectTo: '/admin'
        });

        $locationProvider.html5Mode(true);
    }
]);

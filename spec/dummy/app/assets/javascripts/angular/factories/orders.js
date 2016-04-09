App.factory('Order', ['$resource', function($resource) {
    return $resource('/api/orders/:id.json', null, {
        'update': {
            method: 'PATCH'
        },
        'search': {
            method: 'PATCH',
            isArray: true
        }
    });
}]);


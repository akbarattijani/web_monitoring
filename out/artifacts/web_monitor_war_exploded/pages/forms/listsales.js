angular.loadDirective['forms.listsales'] = ['GridDirective'];
angular.lazy
    .controller('listController', function ($rootScope, $scope, $state,
                                                    $stateParams, $timeout, Rest, AlertMessage , $window , $filter) {

        $scope.sales = [{"merchantName":'asd'}];

    });
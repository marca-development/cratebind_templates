##
# Creates the js and html files for the angular component
# usage: rails g cratebind:angular MODEL_NAME
module Cratebind
    class AngularGenerator < Rails::Generators::NamedBase
      	source_root File.expand_path("../templates", __FILE__)

    	def create_angular
    		 @namespace = ask("What namespace would you like to deploy into? [i.e. admin]")
    		 @columns = class_name.constantize.column_names
    		 @angular_app_name = "#{@namespace}App"
    	end

    	def create_edit
    		create_file "angular/#{@namespace}/#{plural_name}/edit.html", <<-FILE		
<div class="col-md-12">
    <div class="page-header">
        <a class='btn btn-default pull-right' href='/#{@namespace}/#{plural_name}'>
            <i class="fa fa-users"></i>&nbsp;Back To #{plural_name.titlecase}
        </a>
        <a class='btn btn-default pull-right' href='/#{@namespace}/#{plural_name}/{{#{name}.id}}'>
            <i class="fa fa-user"></i>&nbsp;Back
        </a>
        <h1>Editing {{#{name}.name}}</h1>
    </div>
</div>
<div class='col-md-6 col-md-offset-3'>
    <div class='panel panel-primary'>
        <div class='panel-heading'>#{name.titlecase} Information</div>
        <div class='panel-body'>
            <ng-include src="'/angular/#{@namespace}/#{plural_name}/form.html'"></ng-include>
        </div>
    </div>
</div>
    	FILE
	   end

    	def create_form
    		create_file "angular/#{@namespace}/#{plural_name}/form.html", <<-FILE		
<form ng-submit='save#{name.titlecase}(#{name})' class="bootstrap-form-with-validation" name="#{name}Form">
    <div class="form-group">
        <label class="control-label">First Name</label>
        <input class="form-control" ng-model="#{name}.first_name" type="text" required></input>
    </div>
    <div class="form-group">
        <label class="control-label">Last Name</label>
        <input class="form-control" ng-model="#{name}.last_name" type="text" required></input>
    </div>
    <div class="form-group">
        <label class="control-label">Email</label>
        <input name="email" class="form-control" ng-model="#{name}.email" type="text" required></input>
    </div>
    <div class="form-group">
        <label class="control-label">Phone Number</label>
        <input class="form-control" name="phone" phone-input ng-model="#{name}.phone" type="text" required ng-pattern="/\d+/"></input>
    </div>
    <div class="form-group">
        <button class="btn btn-primary" type="submit"> {{#{name}.id == null ? 'Create' : 'Update'}} </button>
    </div>
</form>
    	FILE
    	end

    	def create_new
    		create_file "angular/#{@namespace}/#{plural_name}/new.html", <<-FILE
<div class="col-md-12">
    <div class="page-header">
        <a class='btn btn-default pull-right' href='/#{@namespace}/#{plural_name}'>
            <i class="fa fa-users"></i>&nbsp;Back To #{plural_name.titlecase}
        </a>
        <a class='btn btn-default pull-right' href='/#{@namespace}/#{plural_name}/{{#{name}.id}}'>
            <i class="fa fa-user"></i>&nbsp;Back
        </a>
        <h1>New #{name.titlecase}</h1>
    </div>
</div>
<div class='col-md-6 col-md-offset-3'>
    <div class='panel panel-primary'>
        <div class='panel-heading'>#{name.titlecase} Information</div>
        <div class='panel-body'>
            <ng-include src="'/angular/#{@namespace}/#{plural_name}/form.html'"></ng-include>
        </div>
    </div>
</div>			
    	FILE
    	end

    	def create_show
    		create_file "angular/#{@namespace}/#{plural_name}/show.html", <<-FILE
<div class="col-md-10 col-md-offset-1">
    <div class="page-header">
        <a class='btn btn-white btn-cons pull-right' href='/#{@namespace}/#{plural_name}'>
            <i class="fa fa-home"></i>&nbsp;Back To #{plural_name.titlecase}
        </a>
        <h1>New #{name.titlecase}</h1>
    </div>
</div>
<div class='col-md-6 col-md-offset-3'>
    <div class='panel panel-primary'>
        <div class='panel-heading'>#{plural_name.titlecase} Information</div>
        <div class='panel-body'>
            <table>
                <tr>
                    <td>ID</td>
                    <td>{{#{name}.id}}</td>
                </tr>
            </table>
        </div>
    </div>
</div>		
    	FILE
    	end

    	def create_index
    		create_file "angular/#{@namespace}/#{plural_name}/index.html", <<-FILE
<div class='col-md-12'>
    <div class='panel panel-primary'>
        <div class="panel-heading clearfix">
            <i class="fa fa-users"></i>#{plural_name.titlecase}
        <a class='btn btn-default btn-xs pull-right' href='/#{@namespace}/#{plural_name}/new'>
            <i class="fa fa-plus"></i>&nbsp;Add #{name.titlecase}
        </a>
        <a class='btn btn-default btn-xs pull-right' target='_self' href='/api/#{plural_name}.csv?{{ransackParams(q)}}'>
            <i class="fa fa-file-excel-o"></i>&nbsp;Download
        </a>        
        </div>
        <div class="panel-body">        
        <div class='row'>
            <div class='col-md-3'>
                <div class="form-group">
                    <input placeholder='ID' ng-model='q.id_eq' ng-change='query()' class='form-control'>
                </div>
            </div>
        </div>

        <uib-pagination total-items="totalItems" boundary-links='true' items-per-page='itemsPerPage = 25' rotate='true' max-size='6' force-ellipses='true' rotate='true' ng-model="currentPage" ng-change="query()" ng-show='totalItems > itemsPerPage'></uib-pagination>
        <table class="table table-striped table-bordered table-hover no-more-tables">
            <thead>
                <tr>
                    <th>ID <i class="fa fa-fw fa-sort" ng-click='sortToggle("id")'></i></th>
                </tr>
            </thead>
            <tbody>
                <tr ng-repeat='#{name} in #{plural_name}'>
                    <td><a href='/#{@namespace}/#{plural_name}/{{#{name}.id}}'>{{#{name}.id}}</a></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>			
    	FILE
    	end

    	def create_angular_controller
    		copy_file "angular_controller.rb", "app/controllers/angular_controller.rb"
    		route "get '/angular/*a', to: 'angular#show'"
    	end

    	def angular_routing
            routing_file_path = "app/assets/javascripts/#{@namespace}/angular/routing.js"
            unless File.exist?(routing_file_path)
                create_file "app/assets/javascripts/#{@namespace}/angular/routing.js", <<-FILE
#{@angular_app_name}.config(['$routeProvider', '$locationProvider',
    function($routeProvider, $locationProvider) {
        $routeProvider.

        otherwise({
            redirectTo: '/#{@namespace}'
        });

        $locationProvider.html5Mode(true);
    }
]);
        FILE
            end
            insert_into_file routing_file_path, after: "$routeProvider.\n" do
        "// #{plural_name}
        when('/#{@namespace}/#{plural_name}',{
            templateUrl: '/angular/#{@namespace}/#{plural_name}/index.html',
            controller: '#{plural_name.titlecase}IndexCtrl'
        }).

        when('/#{@namespace}/#{plural_name}/new',{
            templateUrl: '/angular/#{@namespace}/#{plural_name}/new.html',
            controller: '#{plural_name.titlecase}NewCtrl'
        }).

        when('/#{@namespace}/#{plural_name}/:id/edit',{
            templateUrl: '/angular/#{@namespace}/#{plural_name}/edit.html',
            controller: '#{plural_name.titlecase}EditCtrl'
        }).

        when('/#{@namespace}/#{plural_name}/:id',{
            templateUrl: '/angular/#{@namespace}/#{plural_name}/show.html',
            controller: '#{plural_name.titlecase}ShowCtrl'
        })."
            end
    	end

    	def angular_factory
    		create_file "app/assets/javascripts/#{@namespace}/angular/factories/#{plural_name}.js", <<-FILE		
#{@angular_app_name}.factory('#{name.titlecase}', ['$resource', function($resource) {
    return $resource('/api/#{plural_name}/:id.json', null, {
        'update': {
            method: 'PATCH'
        },
        'search': {
            method: 'PATCH',
            isArray: true
        }
    });
}]);

    	FILE
    	end

    	def angular_controller
            create_file "app/assets/javascripts/#{@namespace}/angular/controllers/#{plural_name}.js", <<-FILE     
#{@angular_app_name}Controllers.controller('#{plural_name.titlecase}IndexCtrl', ['$scope', '#{name.titlecase}', 'railsMessages',
    function($scope, #{name.titlecase}, railsMessages) {
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
            #{name.titlecase}.search({}, {
                q: $scope.q,
                page: $scope.currentPage
            }, function(res, headers) {
                $scope.#{plural_name} = res;
                $scope.totalItems = headers().totalitems;
                $scope.currentPage = headers().currentpage;
            });
        }

        $scope.destroy#{name.titlecase} = function(#{name}) {
            #{name.titlecase}.delete({
                id: #{name}.id
            }, function() {
                var index = $scope.#{plural_name}.indexOf(#{name});
                $scope.#{plural_name}.splice(index, 1);
            }, function(err) {
                railsMessages.process(err);
            });
        }

        $scope.currentPage = 1;
        $scope.query();

    }
]);

#{@angular_app_name}Controllers.controller('#{plural_name.titlecase}NewCtrl', ['$scope', '#{name.titlecase}', 'railsMessages', '$location',
    function($scope, #{name.titlecase}, railsMessages, $location) {
        $scope.#{name} = new #{name.titlecase}();

        $scope.save#{name.titlecase} = function(#{name}) {
            #{name.titlecase}.save(#{name}, function(res) {
                railsMessages.add('#{name.titlecase} was created successfully', 'alert alert-success');
                $location.path('/#{@namespace}/#{plural_name}/' + res.id);
            }, function(err) {
                railsMessages.process(err);
            });
        }

    }
]);

#{@angular_app_name}Controllers.controller('#{plural_name.titlecase}EditCtrl', ['$scope', 'railsMessages', '$location', '#{name.titlecase}', '$routeParams',
    function($scope, railsMessages, $location, #{name.titlecase}, $routeParams) {

        $scope.#{name} = #{name.titlecase}.get({
            id: $routeParams.id
        });

        $scope.save#{name.titlecase} = function(#{name}) {
            #{name}.$update({
                id: #{name}.id
            }, function(res) {
                railsMessages.add('#{name.titlecase} was updated successfully', 'alert alert-success');
                $location.path('/#{@namespace}/#{plural_name}/' + res.id);
            }, function(err) {
                railsMessages.process(err);
            });
        }

    }
]);

#{@angular_app_name}Controllers.controller('#{plural_name.titlecase}ShowCtrl', ['$scope', '#{name.titlecase}', '$routeParams',
    function($scope, #{name.titlecase}, $routeParams) {

        $scope.#{name} = #{name.titlecase}.get({
            id: $routeParams.id
        });

    }
]);
        FILE
	   end

    end
end
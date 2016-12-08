var app = angular.module('app', []);
app.controller("Ctrl", function($scope){
	var $ctrl = this;
  $ctrl.inbound = '';
  $ctrl.outbound = '';
  $ctrl.msg = function(message) {
  	$ctrl.outbound = message;
  	$scope.$apply();
  };
});


app.component('nglr', {
	templateUrl: 'nglr.html',
	controller: Nglr,
	bindings: {
		something: '='
	}
});

function Nglr() {
	var $ctrl = this;

	$ctrl.myvalue =  $ctrl.something;

	$ctrl.update = function() {
		$ctrl.something = $ctrl.myvalue;
	};
}


app.component('elm', {
		template: '<div class="elm" id="elm_{{$ctrl.module}}"></div>',
		controller: RunElm,
		bindings: {
			module: '@',
			input: '<',
			output: '&'
		}
	});

RunElm.$inject = ['$element', '$rootScope'];
function RunElm($element, $rootScope) {
	var $ctrl = this;

	var div = $element.children()[0];
	var app = Elm[$ctrl.module].embed(div);

	$ctrl.$onChanges = function(changes) {
		if($ctrl.input) {
			app.ports.receive.send($ctrl.input);
		}
	};

	app.ports.send.subscribe(function(value) {
		$ctrl.output({message: value});
	});
}

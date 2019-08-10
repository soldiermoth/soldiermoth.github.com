function GooglePlusCtrl($scope, $http) {
}

function TimelineCtrl($scope) {
	var svg = d3.select("#timeline").append("svg").attr("width",400).attr("height",800)
	_.chain(1989).range(new Date().getFullYear() + 1).reverse().each(function(year,index){
		svg.append("circle").attr("cx",50).attr("cy",20 + index * 25).attr("r",5).attr("fill","black")
	})
}

function GithubCtrl($scope, $http) {
	$scope.page = 1;
	$scope.hasMore = true;
	$scope.events = [];
	function fetchEvents() {
		var params = { callback: "JSON_CALLBACK", page: $scope.page }
		$http.jsonp("https://api.github.com/users/soldiermoth/events", { params: params })
			.success(function(resp) {
				$scope.hasMore = _.chain(resp.meta.Link).map(_.last).any(function(m){ return m.rel == "next" }).value()
				$scope.events.push.apply($scope.events,resp.data)
			})
	}
	$scope.capitalize = function(str) { return str.charAt(0).toUpperCase() + str.slice(1); }
	$scope.fetchMore = function() { $scope.page += 1; fetchEvents() }
	fetchEvents()
}

function StackOverflowCtrl($scope, $http, $sce) {
	$scope.page = 1
	$scope.answers = []
	$scope.hasMore = true;
	function fetchAnswers() {
		var params = {
			page: $scope.page,
			order: "desc",
			sort: "creation",
			site: "stackoverflow",
			filter: "!)dwyYtvyHxcBq8NRpT*n2RM-H3dXhQw-hIKAov1.AojZyP0Ia"
		}
		$http.get("http://api.stackexchange.com/2.0/users/68172/answers", { params: params })
			.success(function (resp) {
				$scope.answers.push.apply($scope.answers,resp.items)
				$scope.hasMore = resp.has_more
			})
	}

	$scope.safeBody = function(answer) {
		return $sce.trustAsHtml(answer.body);
	}

	$scope.questionUrl = function(answer) {
		return "//stackoverflow.com/questions/"+answer.question_id;
	}

	$scope.answerUrl = function(answer) {
		return $scope.questionUrl(answer)+"#"+answer.answer_id;
	}

	$scope.fetchMore = function() {
		$scope.page += 1
		fetchAnswers()
	}

	fetchAnswers()
}
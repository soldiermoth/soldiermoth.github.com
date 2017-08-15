function GooglePlusCtrl($scope, $http) {
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

function ProfileCtrl($scope) {
	$scope.profiles = [
		{ name: "Twitter", url: "http://twitter.com/soldiermoth" },
		{ name: "Google+", url: "https://plus.google.com/u/0/+RobertPecksoldiermoth" },
		{ name: "LinkedIn", url: "http://www.linkedin.com/pub/robert-peck/11/616/b54" },
		{ name: "StackOverflow", url: "http://stackoverflow.com/users/68172/soldier-moth" },
		{ name: "StackOverflow Careers", url: "http://careers.stackoverflow.com/peck" },
		{ name: "Github", url: "https://github.com/soldiermoth" },
		{ name: "Facebook", url: "https://www.facebook.com/bobby.peck" }
	]
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
		$http.get("https://api.stackexchange.com/2.0/users/68172/answers", { params: params })
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

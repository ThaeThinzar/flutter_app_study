import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/webapp/StartCounterApp.dart';
import 'package:github/github.dart';
import 'package:intl/intl.dart' as intl;
class GitHubStarCounter extends StatefulWidget{
  final String repositoryName;

  GitHubStarCounter({
    @required this.repositoryName,
  });

  GitHubStarCounterState createState() => GitHubStarCounterState();

}
class GitHubStarCounterState extends State<GitHubStarCounter>{
  GitHub github;

  // The repository information
  Repository repository;
  String errorMessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    github = GitHub();
    fetchRepository();
  }
  Future<void> fetchRepository()async {

    setState(() {
      repository = null;
      errorMessage = null;

    });
    try {
      var repo = await github.repositories
          .getRepository(RepositorySlug.full(widget.repositoryName));
      setState(() {
        repository = repo;
      });
    } on RepositoryNotFound {
      setState(() {
        repository = null;
        errorMessage = '${widget.repositoryName} not found.';
      });
    }
  }
  void didUpdateWidget(GitHubStarCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    // When this widget's [repositoryName] changes,
    // load the Repository information.
    if (widget.repositoryName == oldWidget.repositoryName) {
      return;
    }

    fetchRepository();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.headline4.apply(color: Colors.green);
    final errorStyle = textTheme.bodyText1.apply(color: Colors.red);
    final numberFormat = intl.NumberFormat.decimalPattern();
    if(errorMessage != null){
      return Text(errorMessage, style: errorStyle);
    }
    if (widget.repositoryName != null &&
        widget.repositoryName.isNotEmpty &&
        repository == null) {
      return Text('loading...');
    }
    if (repository == null) {
      // If no repository is entered, return an empty widget.
      return SizedBox();
    }
    return Text(
      '${numberFormat.format(repository.stargazersCount)}',
      style: textStyle,
    );
  }

}
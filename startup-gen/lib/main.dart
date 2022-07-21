import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "StartupGen",
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);
  int index = 0;

  void remover(index) {
    setState(() {
      _suggestions.remove(_suggestions[index]);
    });
  }

  void _cardsPage() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Startup Gen Cards"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: _namesSaved,
                  tooltip: "Sugestões salvas",
                ),
                const SizedBox(
                  width: 50.0,
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.navigation),
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, i) {
                  int index = i;
                  if (index >= _suggestions.length) {
                    _suggestions.addAll(generateWordPairs().take(25));
                  }
                  bool alreadySaved = _saved.contains(_suggestions[index]);
                  return Container(
                    color: Colors.lightBlue,
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 5,
                            child: Container(
                              width: 400,
                              height: 200,
                              child: Row(
                                children: [
                                  Text(
                                    _suggestions[index].asPascalCase,
                                    style: _biggerFont,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (alreadySaved) {
                                          _saved.remove(_suggestions[index]);
                                        } else {
                                          _saved.add(_suggestions[index]);
                                        }
                                      });
                                    },
                                    child: Icon(
                                      alreadySaved
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: alreadySaved ? Colors.red : null,
                                      semanticLabel:
                                          alreadySaved ? "Removed" : "Saved",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        Expanded(
                          child: Card(
                            child: Container(
                              width: 400,
                              height: 200,
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      _suggestions[index + 10].asPascalCase,
                                      style: _biggerFont,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (alreadySaved) {
                                            _saved.remove(
                                                _suggestions[index + 10]);
                                          } else {
                                            _saved
                                                .add(_suggestions[index + 10]);
                                          }
                                        });
                                      },
                                      child: Icon(
                                        alreadySaved
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: alreadySaved ? Colors.red : null,
                                        semanticLabel:
                                            alreadySaved ? "Removed" : "Saved",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  void _namesSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final tiles = _saved.map((pair) {
        return ListTile(
            title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ));
      });
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList()
          : <Widget>[];
      return Scaffold(
        appBar: AppBar(
          title: const Text("Saved names"),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Gen"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _namesSaved,
            tooltip: "Sugestões salvas",
          ),
          const SizedBox(
            width: 50.0,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cardsPage();
        },
        child: const Icon(Icons.navigation),
      ),
      body: ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        int index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        bool alreadySaved = _saved.contains(_suggestions[index]);
        return Dismissible(
            child: ListTile(
              title: Text(
                _suggestions[index].asPascalCase,
                style: _biggerFont,
              ),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    if (alreadySaved) {
                      _saved.remove(_suggestions[index]);
                    } else {
                      _saved.add(_suggestions[index]);
                    }
                  });
                },
                child: Icon(
                  alreadySaved ? Icons.favorite : Icons.favorite_border,
                  color: alreadySaved ? Colors.red : null,
                  semanticLabel: alreadySaved ? "Removed" : "Saved",
                ),
              ),
            ),
            key: Key(_suggestions[index].asPascalCase),
            background: Container(
              color: Colors.red.withOpacity(0.7),
            ),
            onDismissed: (direction) {
              remover(index);
            });
      }),
    );
  }
}
/*
Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? "Removed" : "Saved",
                    ),
                    */
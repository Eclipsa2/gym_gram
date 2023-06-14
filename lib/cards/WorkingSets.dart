import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class WorkingSets extends StatefulWidget {
  final String exerciseId;
  final bool editable;

  WorkingSets({required this.exerciseId, required this.editable});

  @override
  _WorkingSetsState createState() => _WorkingSetsState();
}

class _WorkingSetsState extends State<WorkingSets> {
  List<List<int>> _sets = [];

  bool _isAddingSet = false;
  TextEditingController _repsController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  void _addSet() {
    setState(() {
      _isAddingSet = true;
    });
  }

  void _saveSet() async {
    final reps = int.tryParse(_repsController.text) ?? 0;
    final weight = int.tryParse(_weightController.text) ?? 0;
    if (reps > 0 && weight > 0) {
      await FirebaseFirestore.instance.collection('workingSets').add({
        'reps': reps,
        'weight': weight,
        'exerciseId': widget.exerciseId,
        'timestamp': DateTime.now(),
      });
      setState(() {
//        _sets.add([reps, weight]);
        _isAddingSet = false;
        _repsController.clear();
        _weightController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('workingSets')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }

            if (snapshot.hasData) {
              final sets = snapshot.data!.docs
                  .where((set) => set.get('exerciseId') == widget.exerciseId)
                  .toList();

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    for (final set in sets)
                      Text('${set['reps']} reps, ${set['weight']} kgs'),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator.adaptive();
            }
          },
        ),
        if (!_isAddingSet)
          widget.editable != true
              ? SizedBox(height: 20,)
              : TextButton(
                  onPressed: _addSet,
                  child: Text('Add set'),
                ),
        if (_isAddingSet)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      _isAddingSet = false;
                    });
                  },
                ),
              ),
              Container(
                width: 70,
                child: TextField(
                  controller: _repsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none, 
                    hintText: 'Reps',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 70,
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none, 
                    hintText: 'Weight',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 70,
                child: ElevatedButton(
                  onPressed: _saveSet,
                  child: Text('Save'),
                ),
              ),
              
            ],
          ),
//        for (final set in _sets) Text('${set[0]} reps, ${set[1]} kgs'),
      ],
    );
  }
}

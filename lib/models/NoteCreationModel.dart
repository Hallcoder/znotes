import 'package:flutter/cupertino.dart';

import '../utils/content_types.dart';

class NoteCreationModel with ChangeNotifier{
 final Note _newNote = Note();
 Note get newNote => _newNote;
}
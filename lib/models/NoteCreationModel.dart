import 'package:flutter/cupertino.dart';

import '../utils/content_types.dart';

class NoteCreationModel with ChangeNotifier{
 final Note _note = Note();
 Note get note => _note;
}
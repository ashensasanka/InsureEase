import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
pickVideo()async{
  final picker = ImagePicker();
  XFile? videoFile;
  try{
    videoFile = await picker.pickVideo(source: ImageSource.gallery);
    return videoFile!.path;
  }catch(e){
    print('Error picking video: $e');
  }
}
class Utils {
  static formatPrice(double price) => 'LKR ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
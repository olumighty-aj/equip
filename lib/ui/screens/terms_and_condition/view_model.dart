import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app_setup.logger.dart';

class TermsConditionsViewModel extends BaseViewModel {
  Future<String> fetchTermsAndConditions() async {
    try {
      // Reference to the Firestore collection and document
      CollectionReference equipproCollection =
          FirebaseFirestore.instance.collection('equippro');
      DocumentSnapshot documentSnapshot =
          await equipproCollection.doc('terms_condition').get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Access the data using the 'data' property
        getLogger("TermsANdConditions").i(documentSnapshot.data.toString());
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        getLogger("TermsANdConditions").i(data);

        // Assuming 'content' is the key in the document
        String termsAndConditions = data['terms'];

        return termsAndConditions;
      } else {
        // Document does not exist
        return 'Terms and conditions not found.';
      }
    } catch (error) {
      // Handle errors
      print('Error fetching terms and conditions: $error');
      return 'Error fetching terms and conditions.';
    }
  }
}

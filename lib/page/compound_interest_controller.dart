import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:compound_interest_flutter_app/page/model/compound_interest_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CompoundInterestController extends GetxController{

  var principalAmtController = TextEditingController().obs;

  var onSelectedRoi = "1".obs;
  var onSelectedNoOfTimes = "1".obs;
  var onSelectedNoOfYears = "1".obs;

  var maxLimit = 0.obs;

  // Dropdown options
  var rateOfInterestOptions = <String>[].obs; //1 to 15
  var numberOfTimesOptions = <String>[].obs; // 1,2,4
  var numberOfYearsOptions = <String>[].obs; // 1 to 30


  var compoundInterestModel = CompoundInterestModel().obs;


  @override
  void onInit() {
    super.onInit();
    readJson();
  }

   readJson() async {

      final String response = await rootBundle.loadString('asset/compound_interest.json');
      final data = await json.decode(response);

      print("jsonData $data");

       compoundInterestModel.value =  CompoundInterestModel.fromJson(data);

      print("jsonData ${compoundInterestModel.value.rateOfInterest?.labelText}");

      // Dropdown options
       rateOfInterestOptions.value = compoundInterestModel.value.rateOfInterest!.roiValues.map((e) => e.value).toList(); //  1 to 15
       numberOfTimesOptions.value = compoundInterestModel.value.numberOfTimes!.values.map((e) => e.value).toList();// 1,2,4
       numberOfYearsOptions.value = compoundInterestModel.value.numberOfYears!.values.map((e) => e.value).toList(); // 1 to 30

        maxLimit.value = int.parse(compoundInterestModel.value.principalAmount!.maxAmt) ;
     }

   setNoOfTimeList(String? roi) {
     setNoOfYearList(onSelectedNoOfTimes.value);
      if (roi == 12.toString()) {
        onSelectedNoOfTimes.value = "1";
        numberOfTimesOptions.value = ["1"];
      } else if (roi == 6.toString()) {
        onSelectedNoOfTimes.value = "2";
        numberOfTimesOptions.value = ["2"];
      } else if (roi == 3.toString()) {
        onSelectedNoOfTimes.value = "4";
        numberOfTimesOptions.value = ["4"];
      } else {
        onSelectedNoOfTimes.value = "1";
        numberOfTimesOptions.value = compoundInterestModel.value.numberOfTimes!.values.map((e) => e.value).toList();
      }
    }

   setNoOfYearList(String? freq) {
    var originalList = compoundInterestModel.value.numberOfYears!.values.map((e) => e.value).toList();
     if (freq == 1.toString()) {
       onSelectedNoOfYears.value ="1";
       numberOfYearsOptions.value = originalList.sublist(0, 10);
     } else if (freq == 2.toString()) {
       onSelectedNoOfYears.value ="1";
       numberOfYearsOptions.value = originalList.sublist(0, 20);
     } else if (freq == 3.toString()) {
       onSelectedNoOfYears.value ="1";
       numberOfYearsOptions.value = originalList.sublist(0, 30);
     } else {
       onSelectedNoOfYears.value ="1";
       numberOfYearsOptions.value = compoundInterestModel.value.numberOfYears!.values.map((e) => e.value).toList();
     }
   }

    double getResultCI() {
     // double principal, double rate, int years, int timesCompoundedPerYear

     double rate = double.parse(onSelectedRoi.value);
     double principal = double.parse(principalAmtController.value.text);
     int timesCompoundedPerYear = int.parse(onSelectedNoOfTimes.value);
     int years = int.parse(onSelectedNoOfYears.value);

      double r = rate / 100;

      double amount = principal * pow(1 + r / timesCompoundedPerYear, timesCompoundedPerYear * years);

      return amount;
  }

  void clearAllFields() {
     onSelectedRoi.value = "1";
     onSelectedNoOfTimes.value = "1";
     onSelectedNoOfYears.value = "1";
     principalAmtController.value.clear();
  }

}

// {
// "rate_of_interest": {
// "text_color": "black",
// "text_size": "16",
// "label_text": "Rate of Interest (%)",
// "roi_values": [
// {"label": "1", "value": "1"},
// {"label": "2", "value": "2"},
// {"label": "3", "value": "3"},
// {"label": "4", "value": "4"},
// {"label": "5", "value": "5"},
// {"label": "6", "value": "6"},
// {"label": "7", "value": "7"},
// {"label": "8", "value": "8"},
// {"label": "9", "value": "9"},
// {"label": "10", "value": "10"},
// {"label": "11", "value": "11"},
// {"label": "12", "value": "12"},
// {"label": "13", "value": "13"},
// {"label": "14", "value": "14"},
// {"label": "15", "value": "15"}
// ]
// },
//
// "principal_amount": {
// "hint_text": "Enter principal amount",
// "text_color": "black",
// "text_size": "16",
// "min_amt": {
// "1to3": "10000",
// "4to7": "50000",
// "8to12": "75000",
// "other": "100000"
// },
// "max_amt": "10000000",
// "error_message": "Amount must be between the #minimum# and #maximum# limits"
// },
//
// "number_of_times": {
// "label_text": "Number of Times to Compound per Year",
// "text_color": "black",
// "text_size": "16",
// "values": {
// "twelve": [{"label": "1 time", "value": "1"}],
// "six": [{"label": "2 times", "value": "2"}],
// "three": [{"label": "4 times", "value": "4"}],
// "other": [{"label": "1 time", "value": "1"},{"label": "2 times", "value": "2"},{"label": "4 times", "value": "4"}]
// }
// },
//
// "number_of_years": {
// "label_text": "Number of Years",
// "text_color": "black",
// "text_size": "16",
// "values": {
// "one": [
// {"label": "1 year", "value": "1"},
// {"label": "2 years", "value": "2"},
// {"label": "3 years", "value": "3"},
// {"label": "4 years", "value": "4"},
// {"label": "5 years", "value": "5"},
// {"label": "6 years", "value": "6"},
// {"label": "7 years", "value": "7"},
// {"label": "8 years", "value": "8"},
// {"label": "9 years", "value": "9"},
// {"label": "10 years", "value": "10"}
// ],
// "two": [
// {"label": "1 year", "value": "1"},
// {"label": "2 years", "value": "2"},
// {"label": "3 years", "value": "3"},
// {"label": "4 years", "value": "4"},
// {"label": "5 years", "value": "5"},
// {"label": "6 years", "value": "6"},
// {"label": "7 years", "value": "7"},
// {"label": "8 years", "value": "8"},
// {"label": "9 years", "value": "9"},
// {"label": "10 years", "value": "10"},
// {"label": "11 years", "value": "11"},
// {"label": "12 years", "value": "12"},
// {"label": "13 years", "value": "13"},
// {"label": "14 years", "value": "14"},
// {"label": "15 years", "value": "15"},
// {"label": "16 years", "value": "16"},
// {"label": "17 years", "value": "17"},
// {"label": "18 years", "value": "18"},
// {"label": "19 years", "value": "19"},
// {"label": "20 years", "value": "20"}
// ],
// "four": [
// {"label": "1 year", "value": "1"},
// {"label": "2 years", "value": "2"},
// {"label": "3 years", "value": "3"},
// {"label": "4 years", "value": "4"},
// {"label": "5 years", "value": "5"},
// {"label": "6 years", "value": "6"},
// {"label": "7 years", "value": "7"},
// {"label": "8 years", "value": "8"},
// {"label": "9 years", "value": "9"},
// {"label": "10 years", "value": "10"},
// {"label": "11 years", "value": "11"},
// {"label": "12 years", "value": "12"},
// {"label": "13 years", "value": "13"},
// {"label": "14 years", "value": "14"},
// {"label": "15 years", "value": "15"},
// {"label": "16 years", "value": "16"},
// {"label": "17 years", "value": "17"},
// {"label": "18 years", "value": "18"},
// {"label": "19 years", "value": "19"},
// {"label": "20 years", "value": "20"},
// {"label": "21 years", "value": "21"},
// {"label": "22 years", "value": "22"},
// {"label": "23 years", "value": "23"},
// {"label": "24 years", "value": "24"},
// {"label": "25 years", "value": "25"},
// {"label": "26 years", "value": "26"},
// {"label": "27 years", "value": "27"},
// {"label": "28 years", "value": "28"},
// {"label": "29 years", "value": "29"},
// {"label": "30 years", "value": "30"}
// ]
// }
// },
//
// "output_value": {
// "text_color": "black",
// "label_text": "Calculated Amount",
// "text_size": "16",
// "mode_of_display": "pop_up"
// }
// }

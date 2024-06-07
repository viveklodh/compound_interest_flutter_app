import 'package:compound_interest_flutter_app/page/compound_interest_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CompoundInterestView extends StatelessWidget {
  CompoundInterestView({super.key});

  var controller = Get.put(CompoundInterestController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Compound Interest Calculator',
                style: TextStyle(color: Colors.white))),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _roiDropDown(),
                const SizedBox(height: 30),
                _principalAmount(),
                const SizedBox(height: 30),
                _numberOfTimes(),
                const SizedBox(height: 30),
                _numberOfYearDropDown(),
                const SizedBox(height: 30),
                _calculateButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _calculateButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (_formKey.currentState!.validate()) {
              calculateCI(context);
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child:
              const Text('Calculate', style: TextStyle(color: Colors.white))),
    );
  }

  _numberOfYearDropDown() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No. of Years',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonHideUnderline(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: controller.onSelectedNoOfYears.value,
                onChanged: (value) {
                  controller.onSelectedNoOfYears.value = value ?? "";
                },
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.green), // Dropdown icon
                style: const TextStyle(
                    color: Colors.black, fontSize: 16), // Text style
                items: controller.numberOfYearsOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  _numberOfTimes() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No. of times to compound in a year',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonHideUnderline(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: controller.onSelectedNoOfTimes.value,
                onChanged: (value) {
                  controller.onSelectedNoOfTimes.value = value ?? "";
                  controller.setNoOfYearList(value);
                },
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.green), // Dropdown icon
                style: const TextStyle(
                    color: Colors.black, fontSize: 16), // Text style
                items: controller.numberOfTimesOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  _principalAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Principal Amount',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.principalAmtController.value,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NumberRangeInputFormatter(max: controller.maxLimit.value),
          ],
          decoration: const InputDecoration(
            hintText: 'Enter principal amount',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.green, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
          validator: (value) {
            var selectedRoi = int.parse(controller.onSelectedRoi.value);
            if (value == null || value.isEmpty) {
              return 'Please enter an amount';
            }
            final amount = int.tryParse(value);
            if (amount == null) {
              return 'Please enter a valid number';
            }

            if (controller.onSelectedRoi.value != null) {
              if (selectedRoi >= 1 && selectedRoi <= 3) {
                if (amount < 10000) {
                  return 'Amount should be at least 10000 for ROI 1-3';
                }
              } else if (selectedRoi >= 4 && selectedRoi <= 7) {
                if (amount < 50000) {
                  return 'Amount should be at least 50000 for ROI 4-7';
                }
              } else if (selectedRoi >= 8 && selectedRoi <= 12) {
                if (amount < 75000) {
                  return 'Amount should be at least 75000 for ROI 8-12';
                }
              } else if (selectedRoi >= 13 && selectedRoi <= 15) {
                if (amount < 100000) {
                  return 'Amount should be at least 100000 for ROI 13-15';
                }
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  _roiDropDown() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rate of Interest (%)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonHideUnderline(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: controller.onSelectedRoi.value,
                onChanged: (value) {
                  controller.onSelectedRoi.value = value ?? "";
                  controller.setNoOfTimeList(value);
                },
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.green), // Dropdown icon
                style: const TextStyle(
                    color: Colors.black, fontSize: 16), // Text style
                items: controller.rateOfInterestOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> calculateCI(BuildContext context) async {
    var calculatedAmtText = controller.compoundInterestModel.value.outputValue?.labelText ?? "";
    var result = controller.getResultCI().toStringAsFixed(2);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.green[100],
          ),
          child: AlertDialog(
            title: Text(
              calculatedAmtText,
              style: const TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    result,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.clearAllFields();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

bool validation() {
  return true;
}

class NumberRangeInputFormatter extends TextInputFormatter {
  final int max;

  NumberRangeInputFormatter({required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int value = int.parse(newValue.text);

    if (value > max) {
      return oldValue;
    }

    return newValue;
  }
}

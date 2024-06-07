
class CompoundInterestModel {
  RateOfInterest? rateOfInterest;
  PrincipalAmount? principalAmount;
  NumberOf? numberOfTimes;
  NumberOf? numberOfYears;
  OutputValue? outputValue;

  CompoundInterestModel({
     this.rateOfInterest,
     this.principalAmount,
     this.numberOfTimes,
     this.numberOfYears,
     this.outputValue,
  });

  factory CompoundInterestModel.fromJson(Map<String, dynamic> json) => CompoundInterestModel(
    rateOfInterest: RateOfInterest.fromJson(json["rate_of_interest"]),
    principalAmount: PrincipalAmount.fromJson(json["principal_amount"]),
    numberOfTimes: NumberOf.fromJson(json["number_of_times"]),
    numberOfYears: NumberOf.fromJson(json["number_of_years"]),
    outputValue: OutputValue.fromJson(json["output_value"]),
  );

  Map<String, dynamic> toJson() => {
    "rate_of_interest": rateOfInterest?.toJson(),
    "principal_amount": principalAmount?.toJson(),
    "number_of_times": numberOfTimes?.toJson(),
    "number_of_years": numberOfYears?.toJson(),
    "output_value": outputValue?.toJson(),
  };
}

class NumberOf {
  String labelText;
  String textColor;
  String textSize;
  List<Value> values;

  NumberOf({
    required this.labelText,
    required this.textColor,
    required this.textSize,
    required this.values,
  });

  factory NumberOf.fromJson(Map<String, dynamic> json) => NumberOf(
    labelText: json["label_text"],
    textColor: json["text_color"],
    textSize: json["text_size"],
    values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "label_text": labelText,
    "text_color": textColor,
    "text_size": textSize,
    "values": List<dynamic>.from(values.map((x) => x.toJson())),
  };
}

class Value {
  String label;
  String value;

  Value({
    required this.label,
    required this.value,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}

class OutputValue {
  String textColor;
  String labelText;
  String textSize;
  String modeOfDisplay;

  OutputValue({
    required this.textColor,
    required this.labelText,
    required this.textSize,
    required this.modeOfDisplay,
  });

  factory OutputValue.fromJson(Map<String, dynamic> json) => OutputValue(
    textColor: json["text_color"],
    labelText: json["label_text"],
    textSize: json["text_size"],
    modeOfDisplay: json["mode_of_display"],
  );

  Map<String, dynamic> toJson() => {
    "text_color": textColor,
    "label_text": labelText,
    "text_size": textSize,
    "mode_of_display": modeOfDisplay,
  };
}

class PrincipalAmount {
  String hintText;
  String textColor;
  String textSize;
  MinAmt minAmt;
  String maxAmt;
  String errorMessage;

  PrincipalAmount({
    required this.hintText,
    required this.textColor,
    required this.textSize,
    required this.minAmt,
    required this.maxAmt,
    required this.errorMessage,
  });

  factory PrincipalAmount.fromJson(Map<String, dynamic> json) => PrincipalAmount(
    hintText: json["hint_text"],
    textColor: json["text_color"],
    textSize: json["text_size"],
    minAmt: MinAmt.fromJson(json["min_amt"]),
    maxAmt: json["max_amt"],
    errorMessage: json["error_message"],
  );

  Map<String, dynamic> toJson() => {
    "hint_text": hintText,
    "text_color": textColor,
    "text_size": textSize,
    "min_amt": minAmt.toJson(),
    "max_amt": maxAmt,
    "error_message": errorMessage,
  };
}

class MinAmt {
  String the1To3;
  String the4To7;
  String the8To12;
  String other;

  MinAmt({
    required this.the1To3,
    required this.the4To7,
    required this.the8To12,
    required this.other,
  });

  factory MinAmt.fromJson(Map<String, dynamic> json) => MinAmt(
    the1To3: json["1to3"],
    the4To7: json["4to7"],
    the8To12: json["8to12"],
    other: json["other"],
  );

  Map<String, dynamic> toJson() => {
    "1to3": the1To3,
    "4to7": the4To7,
    "8to12": the8To12,
    "other": other,
  };
}

class RateOfInterest {
  String textColor;
  String textSize;
  String labelText;
  List<Value> roiValues;

  RateOfInterest({
    required this.textColor,
    required this.textSize,
    required this.labelText,
    required this.roiValues,
  });

  factory RateOfInterest.fromJson(Map<String, dynamic> json) => RateOfInterest(
    textColor: json["text_color"],
    textSize: json["text_size"],
    labelText: json["label_text"],
    roiValues: List<Value>.from(json["roi_values"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "text_color": textColor,
    "text_size": textSize,
    "label_text": labelText,
    "roi_values": List<dynamic>.from(roiValues.map((x) => x.toJson())),
  };
}

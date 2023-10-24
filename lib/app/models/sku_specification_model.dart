class SkuSpecification {
  String name;
  Set<SpecificationValue> values;
  SkuSpecification({
    required this.name,
    required this.values,
  });
}

class SpecificationValue {
  String name;
  bool isSelected;
  bool isOptional;
  SpecificationValue({
    required this.name,
    this.isSelected = false,
    this.isOptional = true,
  });
}

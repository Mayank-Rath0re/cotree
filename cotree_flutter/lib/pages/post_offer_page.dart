import 'package:cotree_client/cotree_client.dart';
import 'package:cotree_flutter/components/abs_button_primary.dart';
import 'package:cotree_flutter/components/abs_minimal_box.dart';
import 'package:cotree_flutter/components/abs_multiline_textfield.dart';
import 'package:cotree_flutter/components/abs_range_picker.dart';
import 'package:cotree_flutter/components/abs_text.dart';
import 'package:cotree_flutter/components/abs_textfield.dart';
import 'package:cotree_flutter/main.dart';
import 'package:cotree_flutter/models/constants.dart';
import 'package:cotree_flutter/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostOfferPage extends StatefulWidget {
  const PostOfferPage({super.key});

  @override
  State<PostOfferPage> createState() => _PostOfferPageState();
}

class _PostOfferPageState extends State<PostOfferPage> {
  late UserView userview;
  bool isLoading = true;

  // Form state
  final _formKey = GlobalKey<FormState>();
  int _stepIndex = 0;

  // Controllers
  final TextEditingController title = TextEditingController();
  final TextEditingController offerType = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController qualifications = TextEditingController();

  // Fields
  int selectedDuration = 1;
  bool payAvailable = false;
  int payRange1 = 10000;
  int payRange2 = 40000;
  List<String> qualList = [];

  // UI helpers
  String get payLabel =>
      payAvailable ? "₹$payRange1–₹$payRange2 / mo" : "Not disclosed";

  Future<void> getBuildData() async {
    final userCache = context.read<UserCacheService>();
    // Get or set user
    final user = await userCache.getOrSetUserView(context);
    if (!mounted) return;
    setState(() {
      userview = user;
      isLoading = false;
    });
  }

  bool areTextfieldsEmpty() {
    if (title.text.isEmpty ||
        offerType.text.isEmpty ||
        description.text.isEmpty ||
        location.text.isEmpty ||
        qualList.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    getBuildData();
  }

  @override
  void dispose() {
    title.dispose();
    offerType.dispose();
    description.dispose();
    location.dispose();
    qualifications.dispose();
    super.dispose();
  }

  void _submit() {
    final payText = payAvailable ? "$payRange1-$payRange2" : "N/A";
    if (areTextfieldsEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out all required fields'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    client.work.createWorkOffer(
      userview.userId,
      userview.name,
      title.text,
      payText,
      offerType.text,
      location.text,
      description.text,
      selectedDuration,
      qualList,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final head = Provider.of<ThemeProvider>(context).headColor;
    final textTheme = Theme.of(context).textTheme;

    final offerCategories = isLoading
        ? <String>[]
        : userview.accountType == "Individual"
            ? ["Collab Request", "Internship"]
            : ["Collab Request", "Internship", "Part-Time", "Full-Time"];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("Create New Offer"),
        centerTitle: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Form(
                key: _formKey,
                child: Stepper(
                  currentStep: _stepIndex,
                  onStepTapped: (i) => setState(() => _stepIndex = i),
                  controlsBuilder: (context, details) {
                    final isLast = _stepIndex == 2;
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          AbsButtonPrimary(
                            onPressed: () {
                              if (!isLast) {
                                setState(() => _stepIndex++);
                              } else {
                                _submit();
                              }
                            },
                            text: isLast ? "Create Offer" : "Next",
                          ),
                          const SizedBox(width: 12),
                          if (_stepIndex > 0)
                            OutlinedButton(
                              onPressed: () => setState(() => _stepIndex--),
                              child: const AbsText(
                                  displayString: "Back", fontSize: 14),
                            ),
                        ],
                      ),
                    );
                  },
                  steps: [
                    // STEP 1: Basics
                    Step(
                      isActive: _stepIndex >= 0,
                      title: const Text("Basics"),
                      subtitle: const Text("Title & Type"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AbsText(
                            displayString: "Offer Title",
                            fontSize: 16,
                            headColor: true,
                          ),
                          const SizedBox(height: 8),
                          AbsTextfield(hintText: "Title", controller: title),
                          const SizedBox(height: 16),
                          const AbsText(
                            displayString: "Offer Type",
                            fontSize: 16,
                            headColor: true,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                List.generate(offerCategories.length, (i) {
                              final selected =
                                  offerType.text == offerCategories[i];
                              return ChoiceChip(
                                label: Text(offerCategories[i]),
                                selected: selected,
                                selectedColor: head.withOpacity(.15),
                                labelStyle: TextStyle(
                                  color: selected ? head : null,
                                  fontWeight: selected ? FontWeight.w600 : null,
                                ),
                                onSelected: (val) {
                                  setState(() {
                                    offerType.text =
                                        val ? offerCategories[i] : "";
                                  });
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                    // STEP 2: Details
                    Step(
                      isActive: _stepIndex >= 1,
                      title: const Text("Details"),
                      subtitle: const Text("Overview, Location, Duration"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AbsText(
                            displayString: "Offer Overview",
                            fontSize: 16,
                            headColor: true,
                          ),
                          const SizedBox(height: 8),
                          AbsMultilineTextfield(
                            hintText: "Overview",
                            controller: description,
                            maxLines: 8,
                            border: true,
                          ),
                          const SizedBox(height: 16),
                          const AbsText(
                            displayString: "Location",
                            fontSize: 16,
                            headColor: true,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: ["Remote", "Physical"].map((opt) {
                              final isSelected = location.text == opt;
                              return ChoiceChip(
                                label: Text(opt),
                                selected: isSelected,
                                selectedColor: head.withOpacity(.15),
                                labelStyle: TextStyle(
                                  color: isSelected ? head : null,
                                  fontWeight:
                                      isSelected ? FontWeight.w600 : null,
                                ),
                                onSelected: (_) =>
                                    setState(() => location.text = opt),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          // Duration (months)
                          const AbsText(
                            displayString: "Duration (months)",
                            fontSize: 16,
                            headColor: true,
                          ),
                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Slider(
                                  value: selectedDuration.toDouble(),
                                  min: 0,
                                  max: 60,
                                  divisions: 60,
                                  activeColor: head,
                                  label: "$selectedDuration",
                                  onChanged: (val) {
                                    setState(
                                        () => selectedDuration = val.round());
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: head.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "$selectedDuration mo",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: head,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    // STEP 3: Compensation & Requirements + Preview
                    Step(
                      isActive: _stepIndex >= 2,
                      title: const Text("Comp & Req"),
                      subtitle: const Text("Pay & Qualifications"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AbsText(
                            displayString: "Pay",
                            fontSize: 16,
                            headColor: true,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AbsText(
                                displayString: "Available",
                                fontSize: 14,
                                bold: true,
                              ),
                              Switch(
                                value: payAvailable,
                                onChanged: (val) =>
                                    setState(() => payAvailable = val),
                              ),
                            ],
                          ),
                          AnimatedCrossFade(
                            crossFadeState: payAvailable
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 200),
                            firstChild: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Text(
                                    payLabel,
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: head,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                AbsRangePicker(
                                    initialStart: 5000,
                                    initialEnd: 8000,
                                    onChanged: (val1, val2) {
                                      setState(() {
                                        payRange1 = val1;
                                        payRange2 = val2;
                                      });
                                    })
                              ],
                            ),
                            secondChild: const SizedBox.shrink(),
                          ),
                          const SizedBox(height: 16),
                          const AbsText(
                            displayString: "Qualifications",
                            fontSize: 16,
                            headColor: true,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (int i = 0; i < qualList.length; i++)
                                InputChip(
                                  label: Text(qualList[i]),
                                  onDeleted: () => setState(() {
                                    qualList.removeAt(i);
                                  }),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          AbsMinimalBox(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: AbsMultilineTextfield(
                                    hintText: "Add a qualification",
                                    controller: qualifications,
                                    maxLines: 3,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final text = qualifications.text.trim();
                                    if (text.isNotEmpty) {
                                      setState(() {
                                        qualList.add(text);
                                        qualifications.clear();
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: head,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Live Preview
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.work_outline, color: head),
                                      const SizedBox(width: 8),
                                      Text(
                                        title.text.isEmpty
                                            ? "Untitled Offer"
                                            : title.text,
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    children: [
                                      if (offerType.text.isNotEmpty)
                                        Chip(
                                          label: Text(offerType.text),
                                          backgroundColor: head.withOpacity(.1),
                                        ),
                                      if (location.text.isNotEmpty)
                                        Chip(
                                          label: Text(location.text),
                                          backgroundColor: head.withOpacity(.1),
                                        ),
                                      Chip(
                                        label: Text("${selectedDuration} mo"),
                                        backgroundColor: head.withOpacity(.1),
                                      ),
                                      Chip(
                                        label: Text(payLabel),
                                        backgroundColor: head.withOpacity(.1),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    description.text.isEmpty
                                        ? "No overview provided."
                                        : description.text,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  if (qualList.isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 4),
                                        Text(
                                          "Qualifications",
                                          style: textTheme.labelLarge
                                              ?.copyWith(color: head),
                                        ),
                                        const SizedBox(height: 6),
                                        Wrap(
                                          spacing: 6,
                                          runSpacing: 6,
                                          children: qualList
                                              .take(6)
                                              .map((q) => Chip(label: Text(q)))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

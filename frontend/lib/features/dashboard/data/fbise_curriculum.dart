class SubjectModule {
  final String id;
  final String name;
  final String code;
  final String group;
  final int classGrade;
  final int totalUnits;
  final int completedUnits;
  final String iconKey;
  final String driveFolderUrl; // Aapki Google Drive folder link yahan map hogi

  const SubjectModule({
    required this.id,
    required this.name,
    required this.code,
    required this.group,
    required this.classGrade,
    required this.totalUnits,
    required this.completedUnits,
    required this.iconKey,
    this.driveFolderUrl = '',
  });

  double get progress => totalUnits == 0 ? 0 : completedUnits / totalUnits;
}

// Actual FBISE HSSC-II (Class 12) Data Repository
final List<SubjectModule> fbiseClass12Subjects = [
  const SubjectModule(
    id: 'phy-12',
    name: 'Physics',
    code: 'PHY-502',
    group: 'Pre-Engineering / Pre-Medical',
    classGrade: 12,
    totalUnits: 10,
    completedUnits: 7,
    iconKey: 'atom',
  ),
  const SubjectModule(
    id: 'math-12',
    name: 'Mathematics',
    code: 'MTH-504',
    group: 'Pre-Engineering / ICS',
    classGrade: 12,
    totalUnits: 7,
    completedUnits: 5,
    iconKey: 'calculator',
  ),
  const SubjectModule(
    id: 'chem-12',
    name: 'Chemistry',
    code: 'CHM-503',
    group: 'Pre-Medical / Pre-Engineering',
    classGrade: 12,
    totalUnits: 8,
    completedUnits: 4,
    iconKey: 'flask',
  ),
  const SubjectModule(
    id: 'cs-12',
    name: 'Computer Science',
    code: 'CSC-505',
    group: 'ICS',
    classGrade: 12,
    totalUnits: 7,
    completedUnits: 6,
    iconKey: 'binary',
  ),
  const SubjectModule(
    id: 'eng-12',
    name: 'English Compulsory',
    code: 'ENG-501',
    group: 'All Streams (Combined)',
    classGrade: 12,
    totalUnits: 12,
    completedUnits: 8,
    iconKey: 'book',
  ),
  const SubjectModule(
    id: 'ps-12',
    name: 'Pakistan Studies',
    code: 'PKS-506',
    group: 'All Streams (Combined)',
    classGrade: 12,
    totalUnits: 5,
    completedUnits: 4,
    iconKey: 'globe',
  ),
];

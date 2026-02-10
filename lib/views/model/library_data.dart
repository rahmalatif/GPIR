import 'library_project.dart';

class LibraryData {

  static List<LibraryProject> projects = [

    LibraryProject(
      id: "CS2022-01",
      name: "Smart Attendance System",
      year: "2022",
      description: "QR based attendance tracking system",
      doctor: "Dr. Ahmed Ibrahim",
      teachingAssistant: "Eng. Noha Ali",
      team: ["Rahma Ahmed", "Omar Hassan"],
    ),

    LibraryProject(
      id: "CS2023-02",
      name: "Health Tracker App",
      year: "2023",
      description: "Mobile app for daily health monitoring",
      doctor: "Dr. Mona Salah",
      teachingAssistant: "Eng. Karim Adel",
      team: ["Sara Ali", "Ahmed Mostafa"],
    ),

    LibraryProject(
      id: "CS2024-03",
      name: "AI Recommendation System",
      year: "2024",
      description: "Suggests graduation projects using ML",
      doctor: "Dr. Youssef Kamal",
      teachingAssistant: "Eng. Nada Hany",
      team: ["Laila Samir", "Hassan Fathy"],
    ),
  ];
}

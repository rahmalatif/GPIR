import '../core/logic/api_service.dart';
import '../core/logic/cache_helper.dart';
import '../views/model/project.dart';
import '../views/model/project_result.dart';

class NewProjectService {


  static Future<ProjectResult> checkSimilarity(ProjectIdea idea) async {
    final token = await CacheHelper.getToken();

    if (token == null) {
      throw Exception("No token found");
    }

    final response = await ApiService.addProject(
      token: token,
      projectData: {
        "title": idea.name,
        "description": idea.introduction,
        "tools": idea.technologies,
        "specialization": idea.specializations,

      },
    );

    return ProjectResult.fromJson(response);
  }

}
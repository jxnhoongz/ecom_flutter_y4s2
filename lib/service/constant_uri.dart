abstract class ConstantUri{
  static String baseUri = "https://learn-api.cambofreelance.com";
  static String loginPath = "$baseUri/api/oauth/token";
  static String registerPath = "$baseUri/api/oauth/register";

  // Category endpoints
  static String categoryListPath = "$baseUri/api/app/category/list";
  static String categoryByIdPath = "$baseUri/api/app/category";
  static String categoryCreatePath = "$baseUri/api/app/category/create";

  // Post/Product endpoints
  static String postListPath = "$baseUri/api/app/post/list";
  static String postByIdPath = "$baseUri/api/app/post";
  static String postCreatePath = "$baseUri/api/app/post/create";

  // Image endpoints
  static String imageBasePath = "$baseUri/api/public/view/image";
  static String imageUploadPath = "$baseUri/app/public/v1/image/upload";
}
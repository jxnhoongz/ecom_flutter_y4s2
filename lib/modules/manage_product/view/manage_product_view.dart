import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/manage_product_view_model.dart';

class ManageProductView extends StatelessWidget {
  ManageProductView({super.key});

  final manageProductViewModel = Get.put(ManageProductViewModel());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Create Product',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Field
            Text(
              'Product Title',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter product title',
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),

            const SizedBox(height: 20),

            // Description Field
            Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter product description',
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),

            const SizedBox(height: 20),

            // Category Dropdown
            Text(
              'Category',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (manageProductViewModel.isLoadingCategories.value) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              if (manageProductViewModel.categories.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'No categories available. Create a category first.',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<int>(
                  value: manageProductViewModel.selectedCategoryId.value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: manageProductViewModel.categories.map((category) {
                    return DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name ?? 'Unknown'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    manageProductViewModel.selectedCategoryId.value = value;
                  },
                ),
              );
            }),

            const SizedBox(height: 20),

            // Image Upload Section
            Text(
              'Product Image',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),

            Obx(() {
              final selectedImage = manageProductViewModel.selectedImage.value;

              if (selectedImage != null) {
                // Show selected image with preview
                return Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(selectedImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: manageProductViewModel.pickImage,
                            icon: const Icon(Icons.image),
                            label: const Text('Change Image'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: manageProductViewModel.removeImage,
                            icon: const Icon(Icons.delete),
                            label: const Text('Remove'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }

              // Show image picker buttons
              return Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: manageProductViewModel.pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text('Gallery'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: manageProductViewModel.takePhoto,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 32),

            // Create Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: manageProductViewModel.isCreating.value
                        ? null
                        : () {
                            manageProductViewModel.createProduct(
                              titleController.text,
                              descriptionController.text,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: manageProductViewModel.isCreating.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: colorScheme.onPrimary,
                                  strokeWidth: 2,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                manageProductViewModel.isUploadingImage.value
                                    ? 'Uploading image...'
                                    : 'Creating product...',
                                style: TextStyle(
                                  color: colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Create Product',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                )),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

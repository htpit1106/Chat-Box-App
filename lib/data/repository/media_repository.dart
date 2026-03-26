import 'package:photo_manager/photo_manager.dart';

abstract class MediaRepository {
  Future<List<AssetEntity>> getRecentMedias();
}

class MediaRepositoryImpl extends MediaRepository {
  @override
  Future<List<AssetEntity>> getRecentMedias() async {
    // request permission
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return [];
    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.common,
    );
    final recentAlbum = albums.first;
    final medias = recentAlbum.getAssetListPaged(page: 0, size: 100);
    return medias;
  }
}

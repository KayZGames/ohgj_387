import 'package:asset_data/asset_data.dart';

part 'assets.g.dart';

@Asset('asset:ohgj_387/assets/img/assets.json')
const assetsJson = JsonAsset(_assetsJson$asset);

@Asset('asset:ohgj_387/assets/img/assets.png')
const assetsImg = BinaryAsset(_assetsImg$asset);

import 'package:flutter/material.dart';
import 'package:simple_board/controller/service/pagination.dart';

class PaginationUtils {

  static void paginate({
    required ScrollController controller,
    required Pagination provider
  }) {
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면 새로운 데이터를 추가 요청
    if (controller.offset >=
        controller.position.maxScrollExtent - 300) {
      // ref.read를 사용하면 해당하는 Provider가 한 번 호출이 계속 생성이 된 상태로 있음
      // paginate를 일반화 해놓았기 때문에 
      // ref.read(restaurantProvider.notifier).paginate(fetchMore: true); 
      // 대신 아래와 같이 사용 가능
      provider.paginate(fetchMore: true);
    }
  }
}
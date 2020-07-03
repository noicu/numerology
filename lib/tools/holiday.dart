/// 节假日
///
/// @author 6tail
class Holiday {
  /// 日期，YYYY-MM-DD格式 */
  String day;

  /// 名称，如：国庆 */
  String name;

  /// 是否调休，即是否要上班 */
  bool work;

  /// 关联的节日，YYYY-MM-DD格式 */
  String target;

  /// 初始化
  /// @param day 日期
  /// @param name 名称
  /// @param work 是否调休
  /// @param target 关联的节日
  Holiday(String day, String name, bool work, String target) {
    if (!day.contains("-")) {
      this.day = day.substring(0, 4) +
          "-" +
          day.substring(4, 6) +
          "-" +
          day.substring(6);
    } else {
      this.day = day;
    }
    this.name = name;
    this.work = work;
    if (!target.contains("-")) {
      this.target = target.substring(0, 4) +
          "-" +
          target.substring(4, 6) +
          "-" +
          target.substring(6);
    } else {
      this.target = target;
    }
  }

  /// 获取日期
  /// @return 日期
  String getDay() {
    return day;
  }

  /// 设置日期
  /// @param day 日期
  void setDay(String day) {
    this.day = day;
  }

  /// 获取名称
  /// @return 名称
  String getName() {
    return name;
  }

  /// 设置名称
  /// @param name 名称
  void setName(String name) {
    this.name = name;
  }

  /// 是否调休
  /// @return true/false
  bool isWork() {
    return work;
  }

  /// 设置是否调休
  /// @param work true/false
  void setWork(bool work) {
    this.work = work;
  }

  /// 获取关联的节日
  /// @return 节日
  String getTarget() {
    return target;
  }

  /// 设置关联的节日
  /// @param target 节日
  void setTarget(String target) {
    this.target = target;
  }

  @override
  String toString() {
    return day + " " + name + (work ? "调休" : "") + " " + target;
  }
}

class VideoClip {
  final String fileName;
  final String thumbName;
  final String parent;
  int runningTime;

  VideoClip( this.fileName, this.thumbName, this.runningTime, this.parent);

  String videoPath() {
    return "$parent/$fileName";
  }

  String thumbPath() {
    return "$parent/$thumbName";
  }



  static List<VideoClip> remoteClips = [
    VideoClip('冰火 享受篇30秒.mp4', 'image', 0, 'https://firebasestorage.googleapis.com/v0/b/gomart-358609.appspot.com/o/files%2F%E5%86%B0%E7%81%AB%20%E4%BA%AB%E5%8F%97%E7%AF%8730%E7%A7%92.mp4?alt=media&token=a9685775-6512-45cb-8a08-63a518addc70'),
    VideoClip("想要的只能觀望有了清新笑容自信迎接更好的自己.mp4", "images", 0, "https://firebasestorage.googleapis.com/v0/b/gomart-358609.appspot.com/o/files%2F%E6%83%B3%E8%A6%81%E7%9A%84%E5%8F%AA%E8%83%BD%E8%A7%80%E6%9C%9B%E6%9C%89%E4%BA%86%E6%B8%85%E6%96%B0%E7%AC%91%E5%AE%B9%E8%87%AA%E4%BF%A1%E8%BF%8E%E6%8E%A5%E6%9B%B4%E5%A5%BD%E7%9A%84%E8%87%AA%E5%B7%B1.mp4?alt=media&token=7881f16e-f439-4196-99e8-e4302fd09921"),
    VideoClip("露得清DC深層淨化洗面乳 水潤保護層篇 10秒.mp4", "images", 0, "https://firebasestorage.googleapis.com/v0/b/gomart-358609.appspot.com/o/files%2F%E9%9C%B2%E5%BE%97%E6%B8%85DC%E6%B7%B1%E5%B1%A4%E6%B7%A8%E5%8C%96%E6%B4%97%E9%9D%A2%E4%B9%B3%20%E6%B0%B4%E6%BD%A4%E4%BF%9D%E8%AD%B7%E5%B1%A4%E7%AF%87%2010%E7%A7%92.mp4?alt=media&token=e30e4a0b-8754-4084-9edf-f75d6c61d8ce"),
    //VideoClip("BigBuckBunny.mp4", "images/BigBuckBunny.jpg", 0, "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample"),
  ];

}


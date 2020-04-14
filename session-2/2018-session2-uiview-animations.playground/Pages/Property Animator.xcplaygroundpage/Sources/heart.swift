import UIKit

public class HeartContainerView: UIView {
  
  public let heart: UIImageView = {
    let image = UIImage(named: "heart")
    let view = UIImageView(image: image)
    view.frame = CGRect(x: 0, y: 0, width: 45, height: 39)
    return view
  }()
  
  public override init(frame: CGRect) {
    // Animating view
    super.init(frame: frame)

    heart.center = CGPoint(x: 0, y: 0)

    // Add image to the container
    addSubview(heart)
    backgroundColor = UIColor.white
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

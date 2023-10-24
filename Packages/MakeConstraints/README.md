# MakeConstraints

The way I follow to easily make UI Constraints , I converted it to a package that you can easily use

Add to your project using Swift Package Manager

```
https://github.com/ahmed-yamany/MakeConstraints
```

## How to use

you can add a sub view and center to its super view

```swift

   override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)
        button.sizeConstraints(width: 200, height: 44)
        
        button.centerYInSuperview()
        button.centerXInSuperview()
    
        // or do this
        button.centerInSuperview()
    }

```

Or fill to its super view

```swift

  override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        imageView.fillXSuperViewConstraints()
        imageView.fillYSuperViewConstraints()
        
        // or do this
        imageView.fillSuperviewConstraints()
   
    }

```

fill super view with padding

```swift 

   view.addSubview(imageView)
    imageView.fillXSuperViewConstraints(paddingLeft: 24,
                                        paddingRight: 24)
        
    imageView.fillYSuperViewConstraints(paddingTop: 44,
                                        paddingBottom: 44)


    let padding = UIEdgeInsets(top: 44,left: 24,
                                bottom: 44, right: 24)
        
    imageView.fillSuperviewConstraints(padding: padding)

```

make constraints from all view's anchors

```swift 
    let padding = UIEdgeInsets(top: 44,left: 24,
                                bottom: 44, right: 24)

    imageView.makeConstraints(topAnchor: view.topAnchor,
                                bottomAnchor: view.bottomAnchor,
                                leadingAnchor: view.leadingAnchor,
                                trailingAnchor: view.trailingAnchor,
                                padding: padding
                                )
        
    button.makeConstraints(topAnchor: imageView.bottomAnchor,
                            centerXAnchor: imageView.leadingAnchor)

```

update view's sizes
``` swift 

    button.sizeConstraints(width: 200, height: 44)
        
    button.widthConstraints(200)
    button.heightConstraints(44)
        
    imageView.equalSizeConstraints(300)

```

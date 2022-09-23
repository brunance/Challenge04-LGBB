

import UIKit
let storyBoard: UIStoryboard = UIStoryboard(name: "OnBoard", bundle: nil)

class ViewController: UIPageViewController {

   
    var pages = [UIViewController]()
    let pageControl = UIPageControl() // external - not part of underlying pages
    let initialPage = 0
    let nextButton = UIButton()
    let skipButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CorDaview")
        setup()
        style()
        layout()

    }
}

extension ViewController {
    
  
    func setup() {
        dataSource = self
        delegate = self
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "OnBoard", bundle: nil)
        
        // create an array of viewController
        let page1 = storyBoard.instantiateViewController(withIdentifier: "Page1") as! Page1
        let page2 = storyBoard.instantiateViewController(withIdentifier: "Page2") as! Page2
        let page3 = storyBoard.instantiateViewController(withIdentifier: "Page3") as! Page3

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        // set initial viewController to be displayed
        // Note: We are not passing in all the viewControllers here. Only the one to be displayed.
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
       
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
       
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.clear, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitleColor(.clear, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
       
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)

      
        
        NSLayoutConstraint.activate([
            
           
            
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier:8),
            
            nextButton.widthAnchor.constraint(equalToConstant: 70),
            nextButton.heightAnchor.constraint(equalToConstant: 55),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 300),
            nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 650),
            

            skipButton.widthAnchor.constraint(equalToConstant: 70),
            skipButton.heightAnchor.constraint(equalToConstant: 55),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -293),
            skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 650),
            
            
            
        ])

    }
}
extension ViewController {

   

    @objc func skipTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
        
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
     
       
    }
}

// MARK: - Actions

extension ViewController {
    
   
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - DataSources

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
       
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
     
//        if currentIndex == 0 {pageControl.backgroundColor = UIColor.red}
//        if currentIndex == 1 {pageControl.backgroundColor = UIColor.blue}
//        if currentIndex == 2 {pageControl.backgroundColor = UIColor.green}
        
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 1{
            nextButton.isEnabled = false
        }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        }
        
        else {
            nextButton.isEnabled = true
            return nil
        }
        
    }
}

// MARK: - Delegates

extension ViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}
extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
    
}

// MARK: - ViewControllers

class Page1: UIViewController {
    
    @IBOutlet weak var confeteAmarelo: UIImageView!
    @IBOutlet weak var botao1: UIButton!
    
    override func viewDidDisappear(_ animated: Bool) {
        confeteAmarelo.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        confeteAmarelo.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confeteAmarelo.layer.zPosition = 0
        botao1.layer.zPosition = 1
        confeteAmarelo.layer.opacity = 0.5
    }

   
}

class Page2: UIViewController {
    
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var confeteVermelho: UIImageView!
    
    override func viewDidDisappear(_ animated: Bool) {
        confeteVermelho.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        confeteVermelho.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        confeteVermelho.layer.zPosition = 0
        confeteVermelho.layer.opacity = 0.5
        b2.layer.zPosition = 1
    }
    
}

class Page3: UIViewController {
    @IBOutlet weak var confeteAzul: UIImageView!
    @IBOutlet weak var b3: UIButton!
    
    override func viewDidDisappear(_ animated: Bool) {
        confeteAzul.isHidden = true
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
    
        confeteAzul.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        b3.layer.zPosition = 1
        confeteAzul.layer.zPosition = 0
        confeteAzul.layer.opacity = 0.5
    }
    
    @IBAction func gotoApp(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ListRecipesScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "recipesScreen") as! ListRecipesViewController
        let targetNavigationController = UINavigationController(rootViewController: newViewController)
        targetNavigationController.modalPresentationStyle = .fullScreen
        
        self.present(targetNavigationController, animated: true, completion: nil)
    }
    
}

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let workoutViewController = WorkoutViewController()
        let calendarViewController = CalendarViewController()
        let exerciseViewController = ExerciseViewController()
        let homeNavController = UINavigationController(rootViewController: workoutViewController)
        let calendarNavController = UINavigationController(rootViewController: calendarViewController)
        let exerciseNavController = UINavigationController(rootViewController: exerciseViewController)
        homeNavController.tabBarItem.title = "Add Workouts"
        calendarNavController.tabBarItem.title = "Calendar"
        exerciseNavController.tabBarItem.title = "Exercises"
        calendarNavController.tabBarItem.image = UIImage(systemName: "calendar")
//        calendarNavController.tabBarItem.image = #imageLiteral(resourceName: "calendar")
        homeNavController.tabBarItem.image = UIImage(systemName: "plus")
        exerciseNavController.tabBarItem.image = #imageLiteral(resourceName: "workout_icon")

        
    

//        homeNavController.tabBarItem.image = UIImage(named: "Image")
        viewControllers = [calendarNavController, homeNavController, exerciseNavController]
        
    }
}

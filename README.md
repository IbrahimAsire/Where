# Where
**Important notice**:
In order for the application to work well, the following libraries must be downloaded:
'Firebase/Auth،
'Firebase/Firestore'،
'Firebase/Storage' and
'GooglePlaces' .

It has not been uploaded them because a larger size than allowed.


## Describtion :
**Where** is source for all farmers people who want to take view about coffes from different perspective. For example, quality, price, services and locations it's.
Initially, the apps couers only coffes in Abha city. In the future I'm planning to extend the app to cover all cities in kingdom.
One usefull feature in the app is that the user can upload information about the coffee helshe has been visit.
And the user can add a recommendation for a book , specific coffee .. etc

## User Stories: 

- **Signup:** As a user I can sign up in the platform so that I can used it.
- **Login:** As a user I can login to the platform so that I can log at home page .
- **Profile:** As a user I can edit of prifile from so that amelioration it.
- **Logout:** As a user I can edit of prifile from so that amelioration it.
- **Tab Bar:** As a user I can transfer btween pages of the platform so that easily moving btween pages.
- **CafesScreen:** As a user I can see all existing cafes so that I see information about it.
- **RecommantionVC:** As a user I can write my recommation about coffee or book so that others can benefit.
- **Comment:** As a user I can take feedback so that for others to see.
- **Location:** As a user I can see location to determine location of cafe so that I can go to it.
- **Localization:** As a user I can change of language so that I use my preferred language.
- **News:** As a user I can see news so that see and read.
- **Animation:** As a user I can clicked login button so that I can see this button cahnge.
- **opinipn:** As a user I can writ my opinion so that sees it the developer.


| Component            | Permissions                | Behavior                                                     |
| -------------------- | -------------------------- | ------------------------------------------------------------ |
| SplashPage           | public `<Route>`           | Main page                                                    |
| SignupPage           | public `<Route>`           | Signup form, link to login, go to profile after signup       |
| LoginPage            | public `<Route>`           | Login form, link to signup, go to profile after login        |
| Home Page            | public `<Route>`           | Shows all pages in a tab bar                                 |
| disply CafesPage     | public `<Route>`           | Disply all of cafes                                          |
| Cafe Detail Page     | public `<Route>`           | Details of cafes and see info                                |
| Profile Page         | private `<PrivateRoute>`   | edite photo                                                  |
| News page            | public `<Route>`           | see Arab News                                                |
| Add New Place        | public `<Route>`           | Make info and location                                       |
| Add new Recommantion | public `<Route>`           | Write Recommation                                            |
|                      |                            |                                                              |
|                      |                            |                                                              |
|                      |                            |                                                              |
|                      |                            |                                                              |

### Models :
- User
- Cafe
- Place
- News Api
- News Post

### Views :
- CafeCell
- PlacesCell
- PhotoStoreCell
- NewsPlacesCell

### Controllers :
- TabBarCustom Folder
- - TabBarMain
- - ExitVC
- StartVC Folder
- - Register
- - login
- - profile
- CafesScreen Folder
- - CafesVC
- - ShowDetlsCafe
- - AddComment
- PlacesOnMap Folder
- - PlaceOnMap
- - AddNewPlace
- - PopVC
- - NewPlacesVC
- News Folder
- - News
- - ShowNews
- Recommendation Folder
- - RecommVC
- - Additem
- - AddStore

### Networking:
 Comments
 

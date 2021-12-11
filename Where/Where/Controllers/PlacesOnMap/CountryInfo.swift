
import UIKit

class CountryInfo: UIViewController {
    
    var countryAPI = CountryAPI()
    
    lazy var searchTF = UITextField()
    lazy var currentLocBtn = UIButton()
    lazy var searchBtn = UIButton()
    
    lazy var nameCountry: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Country"
        return $0
    }(UILabel())
    
    lazy var nameCaptil: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Captil"
        return $0
    }(UILabel())
    
    lazy var nameRegion: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Ragion"
        return $0
    }(UILabel())
    
    lazy var populationCount : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Population"
        return $0
    }(UILabel())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        searchTF.delegate = self
        countryAPI.delegate = self

        searchTF.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchTF)
        searchTF.placeholder = "Type Country"
        searchTF.textAlignment = .center
        searchTF.returnKeyType = .search
        NSLayoutConstraint.activate([
            searchTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            searchTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            searchTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50)
        ])
        
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBtn)
        searchBtn.setImage(UIImage(systemName: "sparkle.magnifyingglass"), for: .normal)
        searchBtn.addTarget(self, action: #selector(searchTbd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            searchBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            searchBtn.leftAnchor.constraint(equalTo: searchTF.rightAnchor, constant: -5)
        ])
        
        currentLocBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLocBtn)
        currentLocBtn.setImage(UIImage(systemName: "person.fill.checkmark"), for: .normal)
        currentLocBtn.addTarget(self, action: #selector(currentTbd), for: .touchUpInside)
        NSLayoutConstraint.activate([
            currentLocBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            currentLocBtn.rightAnchor.constraint(equalTo: searchTF.leftAnchor, constant: 5)
            
        ])
        
        view.addSubview(nameCountry)
        NSLayoutConstraint.activate([
            nameCountry.topAnchor.constraint(equalTo: searchTF.bottomAnchor, constant: 20),
            nameCountry.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(nameCaptil)
        NSLayoutConstraint.activate([
            nameCaptil.topAnchor.constraint(equalTo: nameCountry.bottomAnchor, constant: 20),
            nameCaptil.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
        
        view.addSubview(nameRegion)
        NSLayoutConstraint.activate([
            nameRegion.topAnchor.constraint(equalTo: nameCaptil.bottomAnchor, constant: 20),
            nameRegion.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
        
        view.addSubview(populationCount)
        NSLayoutConstraint.activate([
            populationCount.topAnchor.constraint(equalTo: nameRegion.bottomAnchor, constant: 20),
            populationCount.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    //MARK:- action when press on search Btn
    @objc func searchTbd() {
        updateUI()
    }
    
    //MARK:- action when press on current location Btn
    @objc func currentTbd() {
        print("Loc")
    }
    
    // MARK:- to get country data form API
    func updateUI() {
        countryAPI.fetchData(countryName: searchTF.text!)

    }

}

//MARK:- For use delegate function to tetxField
extension CountryInfo: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateUI()
        return true
    }
}

extension CountryInfo: CountryAPIDelegate {
    
    func didRetriveCountryInfo(country: Country) {
        print(country)
        
        DispatchQueue.main.async {
            self.nameCountry.text = country.name.common
    //        nameCaptil.text = country.capital
            self.nameRegion.text = country.region
            self.populationCount.text = String(country.population)
        }
        
    }
}

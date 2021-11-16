//
//  MapVC.swift
//  FourSquareCloneApp
//
//  Created by burak ozen on 25.10.2021.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var locationManager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
       
//        MAP kullanıcının mapteki yerini bulmak
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
//        haritada bir yere basılı tutup kayıt alabilme
        let recognaizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognaizer:)))
        recognaizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(recognaizer)
    }
    
    @objc func chooseLocation(gestureRecognaizer: UIGestureRecognizer) {
//        guest algılandıgında nolucak ilk olarak state ini kontrol etmemiz lazım
        if gestureRecognaizer.state == UIGestureRecognizer.State.began {
            
            let touches = gestureRecognaizer.location(in: self.mapView)
//            touches ı kullanarak kullanıulan noktayı self.mapView kullanılarak kordinata çeviriyoruz.
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.plceType
            
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(coordinates.longitude)
            
            
        }
        
        
    }
    
    
    
//    gerçekten kulanıcının yeri update olunca n olacak napıyoduk onu yazıcaz
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
//        haritayı ne kadar zoomlu gosterecek olan obje ne kadar küçük oa kadr zoomlu
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    
    @objc func saveButtonClicked(){
//        parse save işlemleri
        
        let placeModel = PlaceModel.sharedInstance
        
        let object = PFObject(className: "Places")
        object ["name"] = placeModel.placeName
        object["type"] = placeModel.plceType
        object["atmospehere"] = placeModel.placeAtmosphere
        object ["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5) {
            object ["image"] = PFFileObject(name: "image.jpg", data: imageData)
            
        }
        
        object.saveInBackground { success, error in
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                self.performSegue(withIdentifier: "fromMapVCtoPlacesVC", sender: nil)
            }
        }
        
        
    }
    
    @objc func backButtonClicked(){

//        asagıdakini yapamayız geri donmek için çünkü zaten bu mapVC nin kendi navigation u  onceden baska bir navi de var o yuzden bu yontemle geri donemeyiz. burada dissmiss diyerek sonlandırabiliriz. komple kapatıp bi oncekine don gibi
//        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    

    

}

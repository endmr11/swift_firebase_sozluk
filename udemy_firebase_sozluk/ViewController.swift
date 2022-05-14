//
//  ViewController.swift
//  udemy_firebase_sozluk
//
//  Created by Eren Demir on 14.05.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var ref:DatabaseReference!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kelimeTableView: UITableView!
    var aramaYapiliyorMu = false
    var aramaKelimesi:String?
    var kelimeListesi = [Kelimeler]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        kelimeTableView.delegate = self
        kelimeTableView.dataSource = self
        searchBar.delegate = self
        tumKelimeler()
        kelimeEkle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            print("toDetay")
            if let index = sender as? Int{
                let gidilecekVC = segue.destination as! KelimeDetayViewController
                gidilecekVC.kelime = kelimeListesi[index]
            }
        }
    }
    
    func kelimeEkle() {
        let yeniKelime = Kelimeler(kelime_id: "", turkce: "Tanrı", ingilizce: "God")
        let dict:[String:Any] = ["kelime_id":yeniKelime.kelime_id!,"turkce":yeniKelime.turkce!,"ingilizce":yeniKelime.ingilizce!]
        let newRef = ref.child("kelimeler").childByAutoId()
        newRef.setValue(dict)
    }
    
    func tumKelimeler() {
        ref.child("kelimeler").observe(.value, with: { snapshot in
            if let gelenVeriButunu = snapshot.value as? [String:AnyObject]{
                self.kelimeListesi.removeAll()
                
                for gelenSatirVerisi in gelenVeriButunu {
                    
                    if let sozluk = gelenSatirVerisi.value as? NSDictionary {
                        let key = gelenSatirVerisi.key
                        let turke = sozluk["turkce"] as? String ?? ""
                        let ingilizce = sozluk["ingilizce"] as? String ?? ""
                        let kelime = Kelimeler(kelime_id: key, turkce: turke, ingilizce: ingilizce)
                        self.kelimeListesi.append(kelime)
                    }
                }
                DispatchQueue.main.async {
                    self.kelimeTableView.reloadData()
                }
            }
        })
    }
    
    func aramaYap(aramaKelimesi:String) {
        ref.child("kelimeler").observe(.value, with: { snapshot in
            if let gelenVeriButunu = snapshot.value as? [String:AnyObject]{
                self.kelimeListesi.removeAll()
                
                for gelenSatirVerisi in gelenVeriButunu {
                    
                    if let sozluk = gelenSatirVerisi.value as? NSDictionary {
                        let key = gelenSatirVerisi.key
                        let turke = sozluk["turkce"] as? String ?? ""
                        let ingilizce = sozluk["ingilizce"] as? String ?? ""
                        if ingilizce.contains(aramaKelimesi) {
                            let kelime = Kelimeler(kelime_id: key, turkce: turke, ingilizce: ingilizce)
                            self.kelimeListesi.append(kelime)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.kelimeTableView.reloadData()
                }
            }
        })
    }
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimeListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kelime = kelimeListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kelimeHucre", for: indexPath) as! KelimeHucreTableViewCell
        
        cell.ingilizceLabel.text = kelime.ingilizce
        cell.turkceLabel.text = kelime.turkce
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(kelimeListesi[indexPath.row].kelime_id!)
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
}

extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(print(searchText))
        if searchText == "" {
            tumKelimeler()
        }else {
            aramaYap(aramaKelimesi: searchText)
        }
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel tıklandı")
    }
    
}

//
//  WeatherInfoView.swift
//  Weather
//
//  Created by Virender Dall on 31/08/21.
//

import UIKit

@IBDesignable
class WeatherInfoView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var labelRain: UILabel!
    @IBOutlet var labelForecast: UILabel!
    @IBOutlet var labelTemp: UILabel!
    @IBOutlet var labelHumid: UILabel!
    @IBOutlet var labelWindSpeed: UILabel!
    @IBOutlet var imageWeather: AsyncImageView!
    @IBOutlet var labelDate: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.commonInit()
    }
    
    func commonInit(){
        self.loadView(WeatherInfoView.self)
        self.addSubview(self.view)
        self.setTLBRForView(view: self.view);
        self.superview?.layoutIfNeeded()
    }
    
    func loadInfo(model: CityWeatherViewModel?) {
        if let model = model {
            self.imageWeather.downloadImage(url: model.weatherIcon ?? "")
            self.labelTemp.text = model.temp
            self.labelRain.text = model.clouds
            self.labelWindSpeed.text = model.windSpeed
            self.labelForecast.text = model.weather
            self.labelHumid.text = model.humidity
            self.labelDate.text = model.dateString
        }
    }
}

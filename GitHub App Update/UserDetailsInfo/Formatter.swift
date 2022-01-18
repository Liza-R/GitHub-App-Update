import Foundation

class Formatter{
    func formatteDate(date: String) -> String{
        var newDate = ""
        if date == ""{
            newDate = "Date Not Found"
            return newDate
        }else{
            let d = date.components(separatedBy: "T")
            newDate = d[0]
            return newDate
        }
    }
    func formattePrivate(status: Bool) -> String{
        var newStatus = ""
        switch status{
        case true:
            newStatus = "Private"
        default:
            newStatus = "Public"
        }
        return newStatus
    }
}

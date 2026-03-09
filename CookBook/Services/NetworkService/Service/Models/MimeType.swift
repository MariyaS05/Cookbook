//
//  MimeType.swift
//  NetworkLayer
//


enum MimeType: String {
    case rtf = "application/rtf"
    case markdown = "text/markdown"
    case text = "text/plain"
    case png = "image/png"
    
    /// Use this case for jpg also
    case jpeg = "image/jpeg"
    
    /// Use this case for tiff also
    case tiff = "image/tiff"
    
    case bmp = "image/bmp"
    case svg = "image/svg+xml"
    case dxf = "image/vnd.dxf"
    case gif = "image/gif"
    case psd = "image/vnd.adobe.photoshop"
    
    /// Use this case for heic also
    case heif = "image/heif"
    
    case webp = "image/webp"
    
    /// Use this case for htm also
    case html = "text/html"
    
    /// Use this case for dot also
    case doc = "application/msword"
    case docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    case dotx = "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
    
    case xls = "application/vnd.ms-excel"
    case xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    case xlsb = "application/vnd.ms-excel.sheet.binary.macroenabled.12"
    case xltx = "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
    
    /// Use this case for pps also
    case ppt = "application/vnd.ms-powerpoint"
    case pptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation"
    case potx = "application/vnd.openxmlformats-officedocument.presentationml.template"
    
    case csv = "text/csv"
    
    case eps = "application/postscript"
    case epub = "application/epub+zip"
 
    case odg = "application/vnd.oasis.opendocument.graphics"
    case odp = "application/vnd.oasis.opendocument.presentation"
    case ods = "application/vnd.oasis.opendocument.spreadsheet"
    case odt = "application/vnd.oasis.opendocument.text"
    case pub = "application/x-mspublisher"
    
    /// Use this case for vsdx also
    case vsd = "application/vnd.visio"
    
    case wpd = "application/vnd.wordperfect"
    
    case pdf = "application/pdf"
}

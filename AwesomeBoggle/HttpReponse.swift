import Foundation

struct HttpResponse<T> {
    let status: Int
    let data: T
}

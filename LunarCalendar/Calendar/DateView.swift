//
//  DateView.swift
//  LunarCalendar
//
//  Created by Huy Ta on 9/27/20.
//

import SwiftUI
import SwiftDate

struct DateView: View {
    private let date: DateInRegion
    private var selected: Bool? = false
    private var hasEvents: Bool? = false
    private var onTap: ((DateInRegion) -> Void)? = nil
    
    init(date: DateInRegion, selected: Bool? = false, hasEvents: Bool? = false, onTap: ( (DateInRegion) -> Void)? = nil) {
        self.date = date
        self.selected = selected
        self.hasEvents = hasEvents
        self.onTap = onTap
    }
    
    fileprivate func isToday(date: DateInRegion) -> Bool {
        let today = Date().convertTo(region: date.region)
        return today.day == date.day && today.month == date.month && today.year == date.year
    }

    var body: some View {
        VStack {
            if selected! {
                if isToday(date: date) {
                    DateText(date: date, color: Color.white, onTap: onTap)
                        .background(
                            Circle()
                                .foregroundColor(Color(UIColor.systemRed))
                                .frame(minWidth: 45, minHeight: 45)
                        )
                } else {
                    DateText(date: date, color: Color(UIColor.systemBackground), onTap: onTap)
                        .background(
                            Circle()
                                .foregroundColor(Color(UIColor.label))
                                .frame(minWidth: 45, minHeight: 45)
                        )
                }
            } else {
                if isToday(date: date) {
                    DateText(date: date, color: Color(UIColor.systemRed), onTap: onTap)
                } else {
                    DateText(date: date, onTap: onTap)
                }
            }
            if hasEvents! {
                Circle()
                    .foregroundColor(Color(UIColor.systemGray2))
                    .frame(width: 8, height: 8)
            } else {
                Circle()
                    .frame(width: 8, height: 8)
                    .opacity(0.0)
            }
        }
    }
    
    struct DateText: View {
        let date: DateInRegion
        var color: Color? = nil
        var onTap: ((DateInRegion) -> Void)? = nil

        var body: some View {
            VStack {
                if color != nil {
                    Text(String(date.date.day) + (date.date.day == 1 ? "/\(date.date.month)" : ""))
                        .foregroundColor(color)
                        .frame(maxWidth: .infinity)
                        .font(.caption)
                    Text(String(date.day))
                        .foregroundColor(color)
                } else {
                    Text(String(date.date.day) + (date.date.day == 1 ? "/\(date.date.month)" : ""))
                        .frame(maxWidth: .infinity)
                        .font(.caption)
                    Text(String(date.day))
                }
            }
            .frame(maxWidth: .infinity)
            .onTapGesture {
                if onTap != nil {
                    onTap!(date)
                }
            }
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static let region: Region = Region(calendar: Calendars.chinese,zone: Zones.current, locale: Locales.vietnamese)
    static var previews: some View {
        VStack {
            DateView(date: Date().convertTo(region: region)).padding()
            DateView(date: Date().convertTo(region: region), selected: true).padding()
            DateView(date: Date().convertTo(region: region), selected: true, hasEvents: true).padding()
            DateView(date: "2045-01-01".toDate()!.convertTo(region: region), hasEvents: true).padding()
            DateView(date: "2020-01-01".toDate()!.convertTo(region: region), selected: true, hasEvents: true).padding()
        }
        VStack {
            DateView(date: Date().convertTo(region: region)).padding()
            DateView(date: Date().convertTo(region: region), selected: true).padding()
            DateView(date: "2045-01-01".toDate()!.convertTo(region: region), hasEvents: true).padding()
            DateView(date: "2020-01-01".toDate()!.convertTo(region: region), selected: true, hasEvents: true).padding()
        }.preferredColorScheme(.dark)
    }
}

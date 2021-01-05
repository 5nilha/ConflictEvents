//
//  EventsTableViewController.swift
//  FacebookEvents
//
//  Created by Fabio Quintanilha on 8/8/20.
//  Copyright © 2020 FabioQuintanilha. All rights reserved.
//

import UIKit

class EventsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView = UITableView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height)), style: .plain)
    private var eventsListViewModel: EventsListViewModel?
    private lazy var spinnerController = LoadingSpinnerController()
    
    deinit {
        print("deinitializing EventsTableViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Events"
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.eventsListViewModel = EventsListViewModel(delegate: self)
        
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        self.view.addSubview(self.tableView)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventsListViewModel?.numOfDays ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsListViewModel?.numOfEventsOnSameDayAt(section: section) ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let eventsList = self.eventsListViewModel,
            let event = eventsList.eventAt(indexPath: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier , for: indexPath) as? EventCell
        else {
            return UITableViewCell()
        }
        let cellColor = eventsList.backgroundForEventAt(indexPath: indexPath)
        cell.setupCell(event: event, backgroundColor: cellColor)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 10, y: 4, width: tableView.frame.size.width, height: 18))
        let calendarImageView = UIImageView(frame: CGRect(x: 10, y: 4, width: 20, height: 20))
        calendarImageView.image = UIImage(systemName: "calendar")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let label = UILabel(frame: CGRect(x: 10 + calendarImageView.frame.width + 10, y: 4, width: tableView.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = eventsListViewModel?.sectionTitleAt(section: section) ?? ""
        label.textColor = .white
        view.addSubview(calendarImageView)
        view.addSubview(label)
        view.backgroundColor = self.eventsListViewModel?.sectionViewColor
        return view
    }
}

extension EventsTableViewController: EventListDelegate {
    func didStartLoadingEvent() {
        self.tableView.isHidden = true
        self.addChild(spinnerController)
        self.spinnerController.view.frame = self.view.frame
        self.view.addSubview(spinnerController.view)
        self.spinnerController.didMove(toParent: self)
    }
    
    func didEndLoadingEvent() {
        self.spinnerController.stopSpinner()
        self.spinnerController.willMove(toParent: nil)
        self.spinnerController.view.removeFromSuperview()
        self.spinnerController.removeFromParent()
        self.tableView.isHidden = false
    }
    
    func loadEventDidFail(error: RequestError) {
        let alertController = UIAlertController(title: error.title, message: error.UIDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func didUpdate() {
        self.tableView.reloadData()
    }
}

//
//  CustomPickerTextfield.swift
//  IPadDemo
//
//  Created by vijay vir on 7/8/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import Foundation
import UIKit


@objc protocol PickerTextFieldDelegate :  NSObjectProtocol {
	@objc optional func  pickerTextField(_ pickerTextField: LeoUIPickerTextField, object: String) -> Array<String>
	@objc optional func  pickerTextField(_pickerTextField: LeoUIPickerTextField, textField: String , rangeExceed: Bool)
	@objc optional func  pickerTextField(_ pickerTextField: LeoUIPickerTextField, didSelectRow row: Int, inComponent component: Int) ->String
}

@objc protocol PickerTextFieldDataSourse :  NSObjectProtocol
{
	@objc optional func  pickerTextField(_ pickerTextField: LeoUIPickerTextField, object: String) -> Array<String>
	
	@objc func  pickerTextField(_pickerTextField: LeoUIPickerTextField, numberOfRowsInComponent component: Int ) -> Int
	@objc func  pickerTextField(_pickerTextField: LeoUIPickerTextField, titleForRow row: Int, forComponent component: Int) -> String!
}

class LeoUIPickerTextField: UITextField , UIPickerViewDelegate,UIPickerViewDataSource
{
	
	// MARK: Outlets
	
	
	// MARK: Variables
	
	var pickerView: UIPickerView = UIPickerView()
	
	@IBOutlet  var pickerTextFieldDelegate : PickerTextFieldDelegate?
	
	@IBOutlet  var pickerTextFieldDataSource : PickerTextFieldDataSourse?
	
	// MARK: CLC
	required  init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		
		self.inputView = pickerView
		pickerView.dataSource = self
		pickerView.delegate = self
		
		
		pickerView.showsSelectionIndicator = true
		//        pickerView.addtarget
		//  pickerView.addTarget(self , action: #selector(SkyFloatingLabelPickerTextField.pickerTextFieldValueChanged(_:)), for: UIControlEvents.valueChanged)
		//
		self.addTarget(self , action: #selector(LeoUIPickerTextField.pickerTextFieldEditingDidBegin(_:)), for: UIControlEvents.editingDidBegin)
		
		self.addTarget(self , action: #selector(LeoUIPickerTextField.pickerTextFieldEditingDidEnd(_:)), for: UIControlEvents.editingDidEnd)
		
		
	}
	override func awakeFromNib()
	{
		
		
		super.awakeFromNib()
		print("\(String(describing: self.inputAccessoryView))")
	}
	deinit
	{
		
	}
	// MARK: Action
	
	// MARK: Functions
 
	func pickerTextFieldValueChanged(_ textFieldTemp: UITextField)
	{
		
		
		
	}
	func pickerTextFieldEditingDidBegin(_ textFieldTemp: UITextField)
	{
		
		pickerView.reloadAllComponents()
		
		
	}
	func pickerTextFieldEditingDidEnd(_ textFieldTemp: UITextField)
	{
		
	}
	
	
	//MARK: PickerViewDelegate
	
	
	public func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		return pickerTextFieldDataSource?.pickerTextField(_pickerTextField: self, numberOfRowsInComponent: component) ?? 0
	}
 
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		self.text = pickerTextFieldDataSource?.pickerTextField(_pickerTextField: self, titleForRow: row, forComponent: component) ?? ""
		return  pickerTextFieldDataSource?.pickerTextField(_pickerTextField: self, titleForRow: row, forComponent: component) ?? ""
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{
		
		print("did deselect method is calledd")
		
		self.text =   pickerTextFieldDelegate?.pickerTextField!(self, didSelectRow: row, inComponent: component) ?? ""
		
		//        typePickerView.hidden = false
	}
	
}

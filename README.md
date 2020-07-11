# DatePickerWheels

In iOS 14 beta 2, UIDatePicker doesn't display correctly when used as an inputView on a UIView that is the first responder, even when the `.wheels` style is explicitly specified. It appears to be returned with a CGRect.zero frame. Embedding a UIDatePicker in a normal view hierarchy works fine as expected.

Steps to reproduce:
1. Run the project.
2. Observe that embedding a `.wheels` style UIDatePicker in a normal view hierarchy works as expected.
3. Click "Tap Me" on a view to trigger it to become first responder, and it returns a UIDatePicker with `.wheels` style to be the `inputView`. It also returns a view styled like a toolbar as the `inputAccessoryView`.
4. Observe that only the `inputAccessoryView` toolbar view appears, no date picker.

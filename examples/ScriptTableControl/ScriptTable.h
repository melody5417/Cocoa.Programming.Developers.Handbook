/*
 * ScriptTable.h
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>


@class ScriptTableApplication, ScriptTableDocument, ScriptTableWindow, ScriptTableDocument, ScriptTableRow;

typedef enum {
	ScriptTableSaveOptionsYes = 'yes ' /* Save the file. */,
	ScriptTableSaveOptionsNo = 'no  ' /* Do not save the file. */,
	ScriptTableSaveOptionsAsk = 'ask ' /* Ask the user whether or not to save the file. */
} ScriptTableSaveOptions;

typedef enum {
	ScriptTablePrintingErrorHandlingStandard = 'lwst' /* Standard PostScript error handling */,
	ScriptTablePrintingErrorHandlingDetailed = 'lwdt' /* print a detailed report of PostScript errors */
} ScriptTablePrintingErrorHandling;



/*
 * Standard Suite
 */

// The application's top-level scripting object.
@interface ScriptTableApplication : SBApplication

- (SBElementArray *) documents;
- (SBElementArray *) windows;

@property (copy, readonly) NSString *name;  // The name of the application.
@property (readonly) BOOL frontmost;  // Is this the active application?
@property (copy, readonly) NSString *version;  // The version number of the application.

- (id) open:(id)x;  // Open a document.
- (void) print:(id)x withProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) quitSaving:(ScriptTableSaveOptions)saving;  // Quit the application.
- (BOOL) exists:(id)x;  // Verify that an object exists.

@end

// A document.
@interface ScriptTableDocument : SBObject

@property (copy, readonly) NSString *name;  // Its name.
@property (readonly) BOOL modified;  // Has it been modified since the last save?
@property (copy, readonly) NSURL *file;  // Its location on disk, if it has one.

- (void) closeSaving:(ScriptTableSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(id)as;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (void) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy an object.
- (void) moveTo:(SBObject *)to;  // Move an object to a new location.
- (void) clearRows;  // Clear the rows in the table.
- (void) addRowDisplaying:(NSString *)displaying;  // Add a new row to the table.

@end

// A window.
@interface ScriptTableWindow : SBObject

@property (copy, readonly) NSString *name;  // The title of the window.
- (NSInteger) id;  // The unique identifier of the window.
@property NSInteger index;  // The index of the window, ordered front to back.
@property NSRect bounds;  // The bounding rectangle of the window.
@property (readonly) BOOL closeable;  // Does the window have a close button?
@property (readonly) BOOL miniaturizable;  // Does the window have a minimize button?
@property BOOL miniaturized;  // Is the window minimized right now?
@property (readonly) BOOL resizable;  // Can the window be resized?
@property BOOL visible;  // Is the window visible right now?
@property (readonly) BOOL zoomable;  // Does the window have a zoom button?
@property BOOL zoomed;  // Is the window zoomed right now?
@property (copy, readonly) ScriptTableDocument *document;  // The document whose contents are displayed in the window.

- (void) closeSaving:(ScriptTableSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(id)as;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (void) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy an object.
- (void) moveTo:(SBObject *)to;  // Move an object to a new location.
- (void) clearRows;  // Clear the rows in the table.
- (void) addRowDisplaying:(NSString *)displaying;  // Add a new row to the table.

@end



/*
 * ScriptTable Suite
 */

// A ScriptTable document
@interface ScriptTableDocument (ScriptTableSuite)

- (SBElementArray *) rows;

@end

// An item in the table
@interface ScriptTableRow : SBObject

@property (copy) NSString *title;

- (void) closeSaving:(ScriptTableSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_ as:(id)as;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (void) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy an object.
- (void) moveTo:(SBObject *)to;  // Move an object to a new location.
- (void) clearRows;  // Clear the rows in the table.
- (void) addRowDisplaying:(NSString *)displaying;  // Add a new row to the table.

@end


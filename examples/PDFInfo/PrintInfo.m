#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

void printAttribute(NSDictionary *attributes,
                    const char *title, 
                    id key)
{
	id attribute = [attributes objectForKey: key];
	if (nil != attribute)
	{
		printf("%s: %s\n", title, 
			[[attribute description] UTF8String]);
	}
}

int main(int argc, char **argv)
{
	if (argc != 2) { return 1; };
	[NSAutoreleasePool new];
	NSString *path = [NSString stringWithUTF8String: argv[1]];
	NSURL *url = [NSURL fileURLWithPath: path];
	PDFDocument *doc = [[PDFDocument alloc] initWithURL: url];
	NSDictionary *attributes = [doc documentAttributes];
	printAttribute(attributes, "Title", PDFDocumentTitleAttribute);
	printAttribute(attributes, "Author", PDFDocumentAuthorAttribute);
	printAttribute(attributes, "Creator", PDFDocumentCreatorAttribute);
	printAttribute(attributes, "Subject", PDFDocumentSubjectAttribute);
	printAttribute(attributes, "Producer", PDFDocumentProducerAttribute);
	printAttribute(attributes, "Creation Date", PDFDocumentCreationDateAttribute);
	printAttribute(attributes, "Modification Date", PDFDocumentModificationDateAttribute);
	printAttribute(attributes, "Keywords", PDFDocumentKeywordsAttribute);
	return 0;
}

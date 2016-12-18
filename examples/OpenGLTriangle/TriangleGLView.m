#import "TriangleGLView.h"

@implementation TriangleGLView
- (void)drawRect: (NSRect)rect
{
    glClearColor(1, 1, 1, 0);
    glClear(GL_COLOR_BUFFER_BIT);
    glBegin(GL_TRIANGLES);
    {
		glColor3f(1, 0, 0);
        glVertex3f(0.0,  0.6, 0.0);
		glColor3f(0, 1, 0);
        glVertex3f(-0.6, -0.6, 0.0);
		glColor3f(0, 0, 1);
        glVertex3f(0.6, -0.6,0.0);
    }
    glEnd();
    glFlush();
}

@end

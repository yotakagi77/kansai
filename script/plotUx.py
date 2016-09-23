#!/usr/bin/env python

import sys  # new
import os   # new
import numpy as N
import vtk
import matplotlib.pyplot as P

def load_velocity(filename):
    if not os.path.exists(filename): return None
    reader = vtk.vtkPolyDataReader()
    reader.SetFileName(filename)
    reader.ReadAllVectorsOn()
    reader.Update()

    data = reader.GetOutput()
    cells = data.GetPolys()
    triangles = cells.GetData()
    points = data.GetPoints()
    point_data = data.GetPointData()
    Udata = point_data.GetArray(0)

    ntri = triangles.GetNumberOfTuples()/4
    npts = points.GetNumberOfPoints()
    nvls = Udata.GetNumberOfTuples()

    tri = N.zeros((ntri, 3))
    x = N.zeros(npts)
    y = N.zeros(npts)
    ux = N.zeros(nvls)
    uy = N.zeros(nvls)

    for i in xrange(0, ntri):
        tri[i, 0] = triangles.GetTuple(4*i + 1)[0]
        tri[i, 1] = triangles.GetTuple(4*i + 2)[0]
        tri[i, 2] = triangles.GetTuple(4*i + 3)[0]

    for i in xrange(npts):  # modified
        pt = points.GetPoint(i)
        x[i] = pt[0]
        y[i] = pt[1]

    for i in xrange(0, nvls):  # modified
        U = Udata.GetTuple(i)
        ux[i] = U[0]
        uy[i] = U[1]

    return (x, y, tri, ux, uy)

P.clf()
fn = sys.argv[1]  # new
levels = N.linspace(-1.0, 1.0, 21)
x, y, tri, ux, uy = load_velocity(fn)  # modified
P.tricontour(x, y, tri, ux, levels, linestyles='-',
             colors='black', linewidths=0.5)
P.tricontourf(x, y, tri, ux, levels)
P.xlim([0,0.1])
P.ylim([0,0.1])
P.gca().set_aspect('equal')
P.minorticks_on()
P.gca().set_xticklabels([])
P.gca().set_yticklabels([])
P.title('$U_x$')  # modified
P.savefig("Ux.png", dpi=300, bbox_inches='tight')
P.savefig("Ux.pdf", bbox_inches='tight')
P.show() # modified

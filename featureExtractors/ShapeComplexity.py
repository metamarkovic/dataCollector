from __future__ import division

from FeatureExtractorAbstract import FeatureExtractorAbstract
from helpers.getVoxelData import VoxelData
from scipy.spatial import ConvexHull
from scipy.ndimage import label
import numpy as np
import os
from helpers.config import PathConfig


class ShapeComplexity(FeatureExtractorAbstract):
    
    PCAvector = np.array([ 0.42237685, 0.65776793, 0.62364986])

    def getCSVheader(self):
        return ['hullRatio','triangles', 'limbs', 'shapeComplexity']

    def extract(self, experiment, type, indiv):
        filepath = experiment[2] + os.path.sep + PathConfig.populationFolderNormal + os.path.sep + indiv[0] + "_vox.vxa"

        if not os.path.isfile(filepath):
            return ['NA'] * 4
        vd = VoxelData(filepath)
        dnaMatrix = vd.getDNAmatrix().astype(int)
        ratio, triangles = self.calc_complexity(dnaMatrix)
        limbs = self.calc_limbs(dnaMatrix)

        ratio_norm = ratio                               # No normalization because values are already 0..1
        triangles_norm = (triangles - 12) / (70 - 12)    # Normalization according to the data used to generate PCAvector
        limbs_norm = (limbs - 1) / (5 - 1)               # Normalization according to the data used to generate PCAvector

        shapeComplexity = np.dot(self.PCAvector,np.array([ratio_norm, triangles_norm, limbs_norm]))

        return [ratio, triangles, limbs, shapeComplexity]

    def volume_hull(self, hull):
        def tetrahedron_volume(a, b, c, d):
            return np.abs(np.einsum('ij,ij->i', a-d, np.cross(b-d, c-d))) / 6

        simplices = np.column_stack((np.repeat(hull.vertices[0], hull.nsimplex),
                                 hull.simplices))
        tets = hull.points[simplices]
        return np.sum(tetrahedron_volume(tets[:, 0], tets[:, 1],
                                     tets[:, 2], tets[:, 3]))


    def calc_complexity(self, dnaMatrix):
        points = np.squeeze(np.dstack((dnaMatrix.nonzero())))
        new_points = [] 
        for p in points:
            new_points.append([p[0]+0.5, p[1]+0.5, p[2]+0.5])
            new_points.append([p[0]+0.5, p[1]+0.5, p[2]-0.5])
            new_points.append([p[0]+0.5, p[1]-0.5, p[2]+0.5])
            new_points.append([p[0]+0.5, p[1]-0.5, p[2]-0.5])
            new_points.append([p[0]-0.5, p[1]+0.5, p[2]+0.5])
            new_points.append([p[0]-0.5, p[1]+0.5, p[2]-0.5])
            new_points.append([p[0]-0.5, p[1]-0.5, p[2]+0.5])
            new_points.append([p[0]-0.5, p[1]-0.5, p[2]-0.5])

        new_points = np.array(new_points)
        
        hull = ConvexHull(new_points, qhull_options='FA')
        volume = self.volume_hull(hull)
        ratio = 1-(len(points)/volume)
        triangles = len(hull.simplices)
        
        return ratio, triangles


    def find_centroid(self, dnaMatrix):
        x, y, z = dnaMatrix.nonzero()
        return np.round([np.average(x), np.average(y), np.average(z)])
    
    def remove_area_around_centroid(self, dnaMatrix, centroid, radius=0):
        m = np.copy(dnaMatrix)
        
        if not np.any(m):
            return m
    
        for x in range(max(0,centroid[0]-radius), min(10,centroid[0]+radius+1)):
            for y in range(max(0,centroid[1]-radius), min(10,centroid[1]+radius+1)):
                for z in range(max(0,centroid[2]-radius), min(10,centroid[1]+radius+1)):
                    m[x,y,z] = 0
        return m
    
    def find_islands(self, dnaMatrix):
        dnaMatrix[dnaMatrix>0] = 1
        l, n_islands = label(dnaMatrix)
        return n_islands, l

    
    def calc_limbs(self,dnaMatrix):
        centroid = map(int,self.find_centroid(dnaMatrix).tolist())
        islands = []
        for r in range(10):
            m = self.remove_area_around_centroid(dnaMatrix, centroid, radius=r)
            n_islands, clusters = self.find_islands(m)
            if not np.any(m):
                break
            islands.append(n_islands)
        return max(islands) 
    
    

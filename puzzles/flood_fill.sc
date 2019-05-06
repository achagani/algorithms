import scala.collection.mutable


case class Coordinates(i: Int, j: Int, value: String)

trait FloodFill {

    var visited: mutable.HashMap[Coordinates, String] = mutable.HashMap.empty
    var floods: mutable.HashMap[Coordinates, List[Coordinates]] = mutable.HashMap.empty

    val grid = List(
        List("g", "g", "b", "r"),
        List("g", "b", "r", "b"),
        List("r", "b", "b", "b")
    )

    val ROW = 3
    val COL = 4


    private def printCell(j: Int, cell: String) = {
        print(cell + " ")
        if ((j + 1) % 4 == 0)
            println("")
    }


    private def insertIntoFloods(root_cell: Coordinates, cell: Coordinates) {
        if (floods.keySet.contains(root_cell)) {
            var rootKey = floods(root_cell)
            rootKey = rootKey :+ cell
            floods(root_cell) = rootKey
        } else {
            floods += (root_cell -> List(cell))
        }

        visited += (cell -> cell.value)
    }


    def makeCoordinates(i: Int, j: Int): Coordinates = {
        Coordinates(i, j, grid(i)(j))
    }


    def checkFlood(root_cell: Coordinates, row_idx: Int, col_idx: Int) {

        val currentCord = makeCoordinates(row_idx, col_idx)
        if (visited.keySet.contains(currentCord) || currentCord.value != root_cell.value) return

        val cell = Coordinates(row_idx, col_idx, grid(row_idx)(col_idx))


        insertIntoFloods(root_cell, cell)

        // right
        val right = col_idx + 1
        if (right <= COL - 1) {
            val rCord = makeCoordinates(row_idx, right)
            if (!visited.keySet.contains(rCord) && rCord.value == root_cell.value)
                checkFlood(root_cell, row_idx, right)
        }

        // bottom
        val down = row_idx + 1
        if (down <= ROW - 1) {
            val dCord = makeCoordinates(down, col_idx)
            if (!visited.keySet.contains(dCord) && dCord.value == root_cell.value)
                checkFlood(root_cell, down, row_idx)
        }

        // left
        val left = col_idx - 1
        if (left >= 0) {
            val lCord = makeCoordinates(row_idx, left)
            if (!visited.keySet.contains(lCord) & lCord.value == root_cell.value)
                checkFlood(root_cell, left, row_idx)
        }

        // up
        val up = row_idx + 1
        if (up >= 0) {
            val uCord = makeCoordinates(row_idx, col_idx)
            if (!visited.contains(uCord) & uCord.value == root_cell.value)
                checkFlood(root_cell, up, col_idx)
        }
    }

    def printFloods() = {
        floods.iterator.foreach(f => println(s"${f._1}: ${f._2.length}"))
    }

    def traverse: Unit = {
        for (r <- 0 until ROW) {
            for (c <- 0 until COL) {
                val cord = makeCoordinates(r, c)
                checkFlood(cord, r, c)
            }
        }


        printFloods()
    }

}

val f = new FloodFill {}
f.traverse

<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

$host = "localhost";
$user = "root";
$password = "";
$database = "cotizacionesdb";

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Conexión fallida: " . $conn->connect_error]));
}

$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        if (isset($_GET['action']) && $_GET['action'] === 'export') {
            exportToExcel($conn);
        } elseif (isset($_GET['id'])) {
            getCotizacion($conn, $_GET['id']);
        } else {
            getCotizaciones($conn);
        }
        break;
    case 'POST':
        addOrUpdateCotizacion($conn, $_POST);
        break;
    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"), true);
        deleteCotizacion($conn, $data['id']);
        break;
    default:
        echo json_encode(["success" => false, "message" => "Método no permitido"]);
        break;
}

function getCotizaciones($conn) {
    $page = isset($_GET['page']) ? intval($_GET['page']) : 1;
    $itemsPerPage = isset($_GET['itemsPerPage']) ? intval($_GET['itemsPerPage']) : 10;
    $offset = ($page - 1) * $itemsPerPage;

    $sortColumn = isset($_GET['sortColumn']) ? $_GET['sortColumn'] : 'id';
    $sortOrder = isset($_GET['sortOrder']) && strtolower($_GET['sortOrder']) === 'desc' ? 'DESC' : 'ASC';

    $allowedColumns = ['id', 'modelo', 'marca', 'año', 'precio', 'color', 'detalles_cliente', 'fecha_creacion'];
    if (!in_array($sortColumn, $allowedColumns)) {
        $sortColumn = 'id';
    }

    $stmt = $conn->prepare("SELECT SQL_CALC_FOUND_ROWS * FROM cotizaciones ORDER BY $sortColumn $sortOrder LIMIT ? OFFSET ?");
    $stmt->bind_param("ii", $itemsPerPage, $offset);
    $stmt->execute();
    $result = $stmt->get_result();
    $cotizaciones = $result->fetch_all(MYSQLI_ASSOC);

    $totalItemsResult = $conn->query("SELECT FOUND_ROWS() as total");
    $totalItems = $totalItemsResult->fetch_assoc()['total'];

    echo json_encode(["success" => true, "data" => $cotizaciones, "totalItems" => $totalItems]);
}

function getCotizacion($conn, $id) {
    $stmt = $conn->prepare("SELECT * FROM cotizaciones WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    $cotizacion = $result->fetch_assoc();

    if ($cotizacion) {
        echo json_encode(["success" => true, "data" => $cotizacion]);
    } else {
        echo json_encode(["success" => false, "message" => "Cotización no encontrada"]);
    }
}

function addOrUpdateCotizacion($conn, $data) {
    $id = isset($data['id']) ? intval($data['id']) : null;
    $modelo = $data['modelo'];
    $marca = $data['marca'];
    $año = intval($data['año']);
    $precio = floatval($data['precio']);
    $color = $data['color'];
    $detalles_cliente = $data['detalles_cliente'];
    $fecha_creacion = $data['fecha_creacion'];

    if ($id) {
        $stmt = $conn->prepare("UPDATE cotizaciones SET modelo=?, marca=?, año=?, precio=?, color=?, detalles_cliente=?, fecha_creacion=? WHERE id=?");
        $stmt->bind_param("ssiisssi", $modelo, $marca, $año, $precio, $color, $detalles_cliente, $fecha_creacion, $id);
    } else {
        $stmt = $conn->prepare("INSERT INTO cotizaciones (modelo, marca, año, precio, color, detalles_cliente, fecha_creacion) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssiisss", $modelo, $marca, $año, $precio, $color, $detalles_cliente, $fecha_creacion);
    }

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => $id ? "Cotización actualizada con éxito" : "Cotización agregada con éxito"]);
    } else {
        echo json_encode(["success" => false, "message" => "Error al " . ($id ? "actualizar" : "agregar") . " la cotización"]);
    }
}

function deleteCotizacion($conn, $id) {
    $stmt = $conn->prepare("DELETE FROM cotizaciones WHERE id = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Cotización eliminada con éxito"]);
    } else {
        echo json_encode(["success" => false, "message" => "

Error al eliminar la cotización"]);
    }
}

function exportToExcel($conn) {
    header("Content-Disposition: attachment; filename=cotizaciones.xlsx");
    header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

    $result = $conn->query("SELECT * FROM cotizaciones");

    if ($result->num_rows > 0) {
        $file = fopen("php://output", "w");

        // Escribir encabezados
        $columns = ["ID", "Modelo", "Marca", "Año", "Precio", "Color", "Detalles Cliente", "Fecha Creación"];
        fputcsv($file, $columns, "\t");

        // Escribir datos
        while ($row = $result->fetch_assoc()) {
            fputcsv($file, $row, "\t");
        }

        fclose($file);
    } else {
        echo "No hay datos para exportar";
    }
}

$conn->close();
